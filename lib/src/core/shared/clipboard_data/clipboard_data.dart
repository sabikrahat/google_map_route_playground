import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../ksnackbar/ksnackbar.dart';

Future<void> copyToClipboard(String text, {BuildContext? context, bool showText = true}) async {
  await Clipboard.setData(ClipboardData(text: text)).then((_) {
    if (context == null) return;
    if (!context.mounted) return;
    return KSnackbar.info(context, showText ? 'Copied to clipboard! [$text]' : 'Copied to clipboard!', second: 1);
  });
}

Future<String> getClipboardData() async {
  final data = await Clipboard.getData(Clipboard.kTextPlain);
  return data?.text ?? '';
}
