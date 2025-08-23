import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/db/functions.dart';
import '../../../core/db/paths.dart';
import '../../../injector.dart';

Future<void> deleteDB() async {
  debugPrint('Deleting Database : ${sl<AppDir>().db}');
  await HiveFuntions.closeAllBoxes();
  await HiveFuntions.deleteAllBoxes();
  await sl<AppDir>().root.delete(recursive: true);
  exit(0);
}
