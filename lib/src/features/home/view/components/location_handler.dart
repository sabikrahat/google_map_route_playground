import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/utils/extensions/extensions.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/config/constants.dart';
import '../../../../core/config/size.dart';
import '../../../../core/shared/animations_widget/animated_popup.dart';
import '../../../../core/utils/logger/logger_helper.dart';

Future<void> requestLocationDialog(BuildContext parentCtx) async {
  final pm = await Permission.location.status;
  log.i('>> Location Permission: $pm');
  if (pm.isGranted) return;
  if (!parentCtx.mounted) return;
  return await showDialog(
    context: parentCtx,
    builder: (context) => AnimatedPopup(
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(defaultPadding * 2),
        content: Column(
          mainAxisSize: mainMin,
          children: [
            Container(
              height: 65,
              width: 65,
              padding: const EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: context.theme.primaryColor,
                borderRadius: borderRadius45,
              ),
              child: SvgPicture.asset('assets/svgs/location.svg', width: 10),
            ),
            const SizedBox(height: defaultPadding * 2),
            Text(
              'Location Access Premission Request',
              textAlign: TextAlign.center,
              style: context.text.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: defaultPadding),
            Text(
              'This app needs location access to provide location based services. Please grant location permission.',
              textAlign: TextAlign.center,
              style: context.text.bodyMedium!.copyWith(fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: defaultPadding * 2),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      parentCtx.pop();
                      await _handleLocationPermission(parentCtx);
                      return;
                    },
                    child: Text('Grant Permission'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: defaultPadding),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(onPressed: parentCtx.pop, child: Text('Cancel')),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Future<(bool, String)> _handleLocationPermission(BuildContext context) async {
  LocationPermission permission;
  permission = await Geolocator.checkPermission();
  if (!context.mounted) return (false, 'Please try again.');
  if (permission == LocationPermission.denied) {
    // await requestPermissionDialog(context);
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        EasyLoading.showToast('Location permission is denied');
        return (false, 'Please accept the location permisson');
      }
    } else if (permission == LocationPermission.deniedForever) {
      EasyLoading.showToast(
        'Location permission is permanently denied, we cannot request permission.',
      );
      return (false, 'Please accept the location permisson.');
    }
  } else if (permission == LocationPermission.deniedForever) {
    EasyLoading.showToast(
      'Location permission is permanently denied, we cannot request permission.',
      toastPosition: EasyLoadingToastPosition.bottom,
    );
    return (false, 'Please accept the location permisson.');
  }
  return (true, 'Success');
}
