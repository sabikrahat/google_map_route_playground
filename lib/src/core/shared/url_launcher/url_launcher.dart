import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> externalLaunchUrl(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    EasyLoading.showToast(
      'Could not launch $url',
      toastPosition: EasyLoadingToastPosition.bottom,
      duration: const Duration(seconds: 2),
    );
  }
}
