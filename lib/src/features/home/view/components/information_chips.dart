import 'package:flutter/material.dart';
import 'package:google_map_route_playground/src/core/utils/extensions/extensions.dart';
import 'package:google_map_route_playground/src/features/settings/view/setting_view.dart';

import '../../../../core/config/constants.dart';
import '../../../../core/config/size.dart';
import '../../../../core/utils/themes/themes.dart';
import '../../provider/map_provider.dart';

class InformationChips extends StatelessWidget {
  const InformationChips({super.key, required this.notifier});

  final MapProvider notifier;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: defaultPadding * 2,
      left: defaultPadding / 2,
      right: defaultPadding / 2,
      child: Row(
        mainAxisAlignment: mainSpaceEvenly,
        children: [
          if (notifier.distance != null)
            Chip(
              avatar: const Icon(Icons.straighten, size: 20, color: white),
              label: Text(
                notifier.distance!,
                style: context.text.labelLarge?.copyWith(color: white, fontWeight: FontWeight.w700),
              ),
              backgroundColor: context.theme.primaryColor,
            ),
          if (notifier.duration != null)
            Chip(
              avatar: const Icon(Icons.access_time, size: 20, color: white),
              label: Text(
                notifier.duration!,
                style: context.text.labelLarge?.copyWith(color: white, fontWeight: FontWeight.w700),
              ),
              backgroundColor: context.theme.primaryColor,
            ),
          InkWell(
            radius: 45,
            onTap: () async => await context.goPush(SettingsView.name),
            child: Chip(
              avatar: const Icon(Icons.settings, size: 20, color: white),
              label: Text(
                'Settings',
                style: context.text.labelLarge?.copyWith(color: white, fontWeight: FontWeight.w700),
              ),
              backgroundColor: context.theme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
