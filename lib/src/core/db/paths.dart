import 'dart:io' show Directory;

import 'package:flutter/material.dart' show WidgetsFlutterBinding;
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;

import '../../injector.dart';
import '../config/get_platform.dart';
import '../utils/logger/logger_helper.dart';

Future<void> initDir() async {
  if (sl<PT>().isWeb) return;
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  sl<AppDir>().root = Directory(join(dir.path, '.car_route'));
  sl<AppDir>().db = Directory(join(sl<AppDir>().root.path, 'db'));
  sl<AppDir>().backup = Directory(join(sl<AppDir>().root.path, 'backup'));
  sl<AppDir>().files = Directory(join(sl<AppDir>().root.path, 'files'));
  if (!sl<AppDir>().root.existsSync()) sl<AppDir>().root.createSync(recursive: true);
  if (!sl<AppDir>().db.existsSync()) sl<AppDir>().db.createSync(recursive: true);
  if (!sl<AppDir>().backup.existsSync()) sl<AppDir>().backup.createSync(recursive: true);
  if (!sl<AppDir>().files.existsSync()) sl<AppDir>().files.createSync(recursive: true);
  log.i('App Directory: ${sl<AppDir>().root.path}');
}

class AppDir {
  late Directory db;
  late Directory root;
  late Directory files;
  late Directory backup;
  AppDir();
}
