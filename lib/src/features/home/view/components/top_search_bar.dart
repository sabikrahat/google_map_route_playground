import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_map_route_playground/src/core/config/size.dart';
import 'package:google_map_route_playground/src/core/utils/extensions/extensions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/utils/logger/logger_helper.dart';
import '../../provider/map_provider.dart';
import '../search_address/components/google_maps_helper.dart';
import '../search_address/components/map_prediction_model.dart';
import '../search_address/k_maps_location_input_field.dart';

class TopSearchBar extends ConsumerStatefulWidget {
  const TopSearchBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TopSearchBarState();
}

class _TopSearchBarState extends ConsumerState<TopSearchBar> {
  @override
  Widget build(BuildContext context) {
    ref.watch(mapProvider);
    final notifier = ref.read(mapProvider.notifier);
    return Container(
      padding: const EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          KMapLocationInputField(
            hint: 'Search source address',
            optionsBuilder: (t) async {
              notifier.sourceAddress = t.text;
              return await GoogleMapsHelper().getLocations(t.text);
            },
            initialValue: notifier.sourceAddress,
            displayStringForOption: (v) => v.description!,
            validator: (v) {
              if (v!.isEmpty) {
                return 'Address cannot be empty';
              }
              return null;
            },
            onSelected: (MapPredictionModel v) async {
              log.i('Selected Source Location: $v');
              final data = await GoogleMapsHelper().getLocationBasedOnPlaceId(v.placeId!);
              log.i('Details Result: $data');
              log.i('Latitude: ${data?.geometry?.location?.lat}');
              log.i('Longitude: ${data?.geometry?.location?.lng}');

              if (data == null) return;
              if (data.geometry == null) return;
              if (data.geometry!.location == null) return;

              final latLng = LatLng(data.geometry!.location!.lat!, data.geometry!.location!.lng!);
              log.i('LatLng: $latLng');

              log.i('Source Address: ${notifier.sourceAddress}');

              notifier.setSourceLatLng(latLng);
            },
          ),
          const SizedBox(height: defaultPadding / 2),
          KMapLocationInputField(
            hint: 'Search destination address',
            optionsBuilder: (t) async {
              notifier.destinationAddress = t.text;
              return await GoogleMapsHelper().getLocations(t.text);
            },
            initialValue: notifier.destinationAddress,
            displayStringForOption: (v) => v.description!,
            validator: (v) {
              if (v!.isEmpty) {
                return 'Address cannot be empty';
              }
              return null;
            },
            onSelected: (MapPredictionModel v) async {
              log.i('Selected Destination Location: $v');
              final data = await GoogleMapsHelper().getLocationBasedOnPlaceId(v.placeId!);
              log.i('Details Result: $data');
              log.i('Latitude: ${data?.geometry?.location?.lat}');
              log.i('Longitude: ${data?.geometry?.location?.lng}');

              if (data == null) return;
              if (data.geometry == null) return;
              if (data.geometry!.location == null) return;

              final latLng = LatLng(data.geometry!.location!.lat!, data.geometry!.location!.lng!);
              log.i('LatLng: $latLng');

              log.i('Destination Address: ${notifier.destinationAddress}');

              notifier.setDestinationLatLng(latLng);
            },
          ),
        ],
      ),
    );
  }
}
