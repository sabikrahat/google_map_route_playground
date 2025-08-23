import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../features/settings/model/settings_model.dart';
import '../../injector.dart';
import '../config/constants.dart';
import '../config/get_platform.dart';
import '../utils/extensions/extensions.dart';
import '../utils/logger/logger_helper.dart';
import 'functions.dart';
import 'hive.dart';
import 'paths.dart';

Future<void> openDB() async {
  await initDir();
  await initHiveDB();
}

Future<void> initHiveDB() async {
  try {
    await Hive.initFlutter(sl<PT>().isWeb ? null : sl<AppDir>().db.path);
    HiveFuntions.registerHiveAdepters();
    await HiveFuntions.openAllBoxes();
  } catch (e) {
    log.e('Failed to initialize Hive DB: $e');
    rethrow;
  }
}

Future<void> initAppDatum() async {
  if (Boxes.appSettings.isEmpty) await _appSettingsInit();
  if (sl.isRegistered<AppSettings>()) sl.unregister<AppSettings>();
  sl.registerSingleton<AppSettings>(Boxes.appSettings.get(appName.toCamelWord) ?? AppSettings());
  _listenForAppConfig();
}

Future<void> _appSettingsInit() async {
  final appSettings = AppSettings();
  log.i('First time App Settings Initiated with ${appSettings.firstRunDateTime}');
  log.i('First time App Settings Initiated is first time: ${appSettings.firstRun}');
  await appSettings.saveData();
}

void _listenForAppConfig() => Boxes.appSettings.watch(key: appName.toCamelWord).listen((_) {
  if (sl.isRegistered<AppSettings>()) sl.unregister<AppSettings>();
  sl.registerSingleton<AppSettings>(Boxes.appSettings.get(appName.toCamelWord) ?? AppSettings());
});

final appSettingStreamPd = StreamProvider<AppSettings>(
  (_) => Boxes.appSettings
      .watch(key: appName.toCamelWord)
      .map((event) => event.value ?? AppSettings()),
);
