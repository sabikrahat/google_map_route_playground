import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_map_route_playground/src/core/utils/themes/themes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/utils/logger/logger_helper.dart';

typedef MapNotifier = AsyncNotifierProvider<MapProvider, void>;

final mapProvider = MapNotifier(MapProvider.new);

class MapProvider extends AsyncNotifier<void> {
  Completer<GoogleMapController> _cntrlr = Completer();
  String? sourceAddress;
  LatLng? _sourceLatLng;
  String? destinationAddress;
  LatLng? _destinationLatLng;

  final double _defaultZoomLevel = 12.0;

  @override
  FutureOr<void> build() {
    _cntrlr = Completer();
    // Initialize with sample locations (Dhaka, Bangladesh area)
    // _sourceLatLng = const LatLng(23.8103, 90.4125); // Your location
    // _destinationLatLng = const LatLng(23.7805, 90.2792); // Natore Tower area
  }

  LatLng? get sourceLatLng => _sourceLatLng;
  LatLng? get destinationLatLng => _destinationLatLng;
  double get defaultZoomLevel => _defaultZoomLevel;

  Future<void> setSourceLatLng(LatLng latLng) async {
    _sourceLatLng = latLng;
    await moveCameraToFitBounds();
    ref.notifyListeners();
  }

  Future<void> setDestinationLatLng(LatLng latLng) async {
    _destinationLatLng = latLng;
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
    if (_sourceLatLng == null || _destinationLatLng == null) return <PolylineId, Polyline>{};
    final polylineId = PolylineId('route');
    final polyline = Polyline(
      polylineId: polylineId,
      points: [_sourceLatLng!, _destinationLatLng!],
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
}
