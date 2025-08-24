import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_map_route_playground/src/core/shared/riverpod/helper.dart';
import 'package:google_map_route_playground/src/features/home/provider/map_provider.dart';
import 'package:google_map_route_playground/src/features/home/view/components/top_search_bar.dart';
import 'package:google_map_route_playground/src/features/settings/model/theme/theme_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/config/size.dart';
import '../../../core/initilizer/initializer.dart';
import '../../../injector.dart';
import '../../settings/model/settings_model.dart';

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
                    initialCameraPosition: notifier.cameraPosition,
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
                    top: defaultPadding * 4,
                    left: defaultPadding / 2,
                    right: defaultPadding / 2,
                    child: TopSearchBar(),
                  ),
                ],
              );
            },
          ),
    );
  }
}
