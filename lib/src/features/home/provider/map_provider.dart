import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_map_route_playground/src/core/config/environment.dart';
import 'package:google_map_route_playground/src/core/utils/themes/themes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/logger/logger_helper.dart';

typedef MapNotifier = AsyncNotifierProvider<MapProvider, void>;

final mapProvider = MapNotifier(MapProvider.new);

class MapProvider extends AsyncNotifier<void> {
  Completer<GoogleMapController> _cntrlr = Completer();
  String? sourceAddress;
  LatLng? _sourceLatLng;
  String? destinationAddress;
  LatLng? _destinationLatLng;
  List<LatLng> _routeCoordinates = [];
  String? _distance;
  String? _duration;

  final double _defaultZoomLevel = 12.0;
  final String _apiKey = Environment.googleMapKey;

  @override
  FutureOr<void> build() {
    _cntrlr = Completer();
    _routeCoordinates = [];
  }

  LatLng? get sourceLatLng => _sourceLatLng;
  LatLng? get destinationLatLng => _destinationLatLng;
  String? get distance => _distance;
  String? get duration => _duration;
  double get defaultZoomLevel => _defaultZoomLevel;

  Future<void> setSourceLatLng(LatLng latLng) async {
    _sourceLatLng = latLng;
    if (_destinationLatLng != null) {
      await _getDirections();
    }
    await moveCameraToFitBounds();
    ref.notifyListeners();
  }

  Future<void> setDestinationLatLng(LatLng latLng) async {
    _destinationLatLng = latLng;
    if (_sourceLatLng != null) {
      await _getDirections();
    }
    await moveCameraToFitBounds();
    ref.notifyListeners();
  }

  void onMapCreated(GoogleMapController cntrlr) {
    log.i('Google map controller adding to the completer.');
    if (_cntrlr.isCompleted) _cntrlr = Completer();
    _cntrlr.complete(cntrlr);
  }

  Future<void> moveCameraToFitBounds() async {
    if (_sourceLatLng == null && _destinationLatLng == null) return;
    final controller = await _cntrlr.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  CameraPosition get cameraPosition {
    if (_sourceLatLng != null && _destinationLatLng != null) {
      // camera bounding to include both source and destination
      final southWestLat = (_sourceLatLng!.latitude <= _destinationLatLng!.latitude)
          ? _sourceLatLng!.latitude
          : _destinationLatLng!.latitude;
      final southWestLng = (_sourceLatLng!.longitude <= _destinationLatLng!.longitude)
          ? _sourceLatLng!.longitude
          : _destinationLatLng!.longitude;
      final northEastLat = (_sourceLatLng!.latitude > _destinationLatLng!.latitude)
          ? _sourceLatLng!.latitude
          : _destinationLatLng!.latitude;
      final northEastLng = (_sourceLatLng!.longitude > _destinationLatLng!.longitude)
          ? _sourceLatLng!.longitude
          : _destinationLatLng!.longitude;
      final centerLat = (southWestLat + northEastLat) / 2;
      final centerLng = (southWestLng + northEastLng) / 2;
      return CameraPosition(
        target: LatLng(centerLat, centerLng),
        zoom: _defaultZoomLevel,
        tilt: 0,
        bearing: 0,
      );
    }
    if (_sourceLatLng != null) {
      return CameraPosition(target: _sourceLatLng!, zoom: _defaultZoomLevel, tilt: 0, bearing: 0);
    }
    if (_destinationLatLng != null) {
      return CameraPosition(
        target: _destinationLatLng!,
        zoom: _defaultZoomLevel,
        tilt: 0,
        bearing: 0,
      );
    }
    return CameraPosition(
      target: LatLng(23.7639, 90.2320),
      zoom: _defaultZoomLevel,
      tilt: 0,
      bearing: 0,
    );
  }

  Set<Marker> get markers {
    if (_sourceLatLng == null && _destinationLatLng == null) return <Marker>{};
    Set<Marker> markers = {};
    if (_sourceLatLng != null) {
      final m1 = {
        Marker(
          markerId: const MarkerId('source'),
          position: _sourceLatLng!,
          infoWindow: const InfoWindow(title: 'Source'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      };
      markers.addAll(m1);
    }
    if (_destinationLatLng != null) {
      final m2 = {
        Marker(
          markerId: const MarkerId('destination'),
          position: _destinationLatLng!,
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      };
      markers.addAll(m2);
    }
    return markers;
  }

  Map<PolylineId, Polyline> get polylines {
    if (_routeCoordinates.isEmpty) return <PolylineId, Polyline>{};
    final polylineId = PolylineId('route');
    final polyline = Polyline(
      polylineId: polylineId,
      points: _routeCoordinates,
      color: kPrimaryColor,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      jointType: JointType.round,
      geodesic: true,
      consumeTapEvents: true,
    );
    return {polylineId: polyline};
  }

  Future<void> _getDirections() async {
    if (_sourceLatLng == null || _destinationLatLng == null) return;

    try {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?'
        'origin=${_sourceLatLng!.latitude},${_sourceLatLng!.longitude}&'
        'destination=${_destinationLatLng!.latitude},${_destinationLatLng!.longitude}&'
        'key=$_apiKey',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK' && data['routes'].isNotEmpty) {
          final route = data['routes'][0];
          final polylinePoints = route['overview_polyline']['points'];
          _routeCoordinates = _decodePolyline(polylinePoints);

          // Extract distance and duration
          final legs = route['legs'] as List;
          if (legs.isNotEmpty) {
            _distance = legs[0]['distance']['text'];
            _duration = legs[0]['duration']['text'];
          }
        } else {
          log.e('Directions API error: ${data['status']}');
          _routeCoordinates = [_sourceLatLng!, _destinationLatLng!];
          _distance = null;
          _duration = null;
        }
      } else {
        log.e('HTTP error: ${response.statusCode}');
        _routeCoordinates = [_sourceLatLng!, _destinationLatLng!];
        _distance = null;
        _duration = null;
      }
    } catch (e) {
      log.e('Error fetching directions: $e');
      _routeCoordinates = [_sourceLatLng!, _destinationLatLng!];
      _distance = null;
      _duration = null;
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polylineCoordinates = [];
    int index = 0;
    int len = encoded.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int b;
      int shift = 0;
      int result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      polylineCoordinates.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return polylineCoordinates;
  }
}
