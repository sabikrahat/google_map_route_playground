import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/db/init.dart';
import '../../../core/shared/riverpod/helper.dart';
import '../provider/map_provider.dart';
import 'components/top_search_bar.dart';
import '../../settings/model/theme/theme_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/config/size.dart';
import '../../../core/initilizer/initializer.dart';
import '../../../injector.dart';
import '../../settings/model/settings_model.dart';
import 'components/information_chips.dart';

class MapView extends ConsumerStatefulWidget {
  const MapView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapViewState();
}

class _MapViewState extends ConsumerState<MapView> {
  GoogleMapController? _cntrlr;

  @override
  void dispose() {
    _cntrlr?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(appSettingStreamPd);
    return Scaffold(
      body: ref
          .watch(mapProvider)
          .when(
            loading: riverpodLoading,
            error: riverpodError,
            data: (_) {
              final notifier = ref.read(mapProvider.notifier);
              return Stack(
                children: [
                  GoogleMap(
                    key: const ValueKey('track'),
                    padding: const EdgeInsets.all(defaultPadding / 2),
                    initialCameraPosition: CameraPosition(
                      target: LatLng(23.7639, 90.2320), // dhaka center
                      zoom: notifier.defaultZoomLevel,
                      tilt: 0,
                      bearing: 0,
                    ),
                    onMapCreated: (v) {
                      notifier.onMapCreated(v);
                      _cntrlr = v;
                    },
                    myLocationEnabled: false,
                    myLocationButtonEnabled: false,
                    mapType: MapType.normal,
                    markers: notifier.markers,
                    polylines: Set<Polyline>.of(notifier.polylines.values),
                    trafficEnabled: false,
                    style: sl.call<AppSettings>().theme.isCoreLight(context)
                        ? googleMapLightStyle
                        : googleMapDarkStyle,
                    zoomControlsEnabled: false,
                  ),
                  Positioned(
                    top: topBarSize + defaultPadding / 2,
                    left: defaultPadding / 2,
                    right: defaultPadding / 2,
                    child: TopSearchBar(),
                  ),
                  if (notifier.sourceLatLng != null)
                    Positioned(
                      bottom: defaultPadding * 10,
                      right: defaultPadding,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(shape: CircleBorder()),
                        onPressed: notifier.sourceLatLng == null
                            ? null
                            : () async {
                                await _cntrlr?.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                      target: notifier.sourceLatLng!,
                                      zoom: notifier.defaultZoomLevel,
                                    ),
                                  ),
                                );
                              },
                        child: const Icon(Icons.my_location, color: Colors.white, size: 22),
                      ),
                    ),
                  if (notifier.destinationLatLng != null)
                    Positioned(
                      bottom: defaultPadding * 6,
                      right: defaultPadding,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(shape: CircleBorder()),
                        onPressed: notifier.destinationLatLng == null
                            ? null
                            : () async {
                                await _cntrlr?.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                      target: notifier.destinationLatLng!,
                                      zoom: notifier.defaultZoomLevel,
                                    ),
                                  ),
                                );
                              },
                        child: const Icon(Icons.location_pin, color: Colors.white, size: 22),
                      ),
                    ),
                  InformationChips(notifier: notifier),
                ],
              );
            },
          ),
    );
  }
}
