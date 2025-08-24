import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_map_route_playground/src/core/utils/themes/themes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/utils/logger/logger_helper.dart';

typedef MapNotifier = AsyncNotifierProvider<MapProvider, void>;

final mapProvider = MapNotifier(MapProvider.new);

class MapProvider extends AsyncNotifier<void> {
  Completer<GoogleMapController> _cntrlr = Completer();
  LatLng? _sourceLatLng;
  LatLng? _destinationLatLng;

  final double _defaultZoomLevel = 16.0;

  @override
  FutureOr<void> build() {}

  LatLng? get sourceLatLng => _sourceLatLng;
  LatLng? get destinationLatLng => _destinationLatLng;
  double get defaultZoomLevel => _defaultZoomLevel;

  void onMapCreated(GoogleMapController cntrlr) {
    log.i('Google map controller adding to the completer.');
    if (_cntrlr.isCompleted) _cntrlr = Completer();
    _cntrlr.complete(cntrlr);
  }

  CameraPosition get cameraPosition {
    if (_sourceLatLng != null) {
      return CameraPosition(
        target: LatLng(_sourceLatLng!.latitude, _sourceLatLng!.longitude),
        zoom: _defaultZoomLevel,
        tilt: 0,
        bearing: 0,
      );
    }
    if (_destinationLatLng != null) {
      return CameraPosition(
        target: LatLng(_destinationLatLng!.latitude, _destinationLatLng!.longitude),
        zoom: _defaultZoomLevel,
        tilt: 0,
        bearing: 0,
      );
    }
    return CameraPosition(target: LatLng(0, 0), zoom: _defaultZoomLevel, tilt: 0, bearing: 0);
  }

  Set<Marker> get markers {
    if (_sourceLatLng == null && _destinationLatLng == null) <Marker>{};
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
