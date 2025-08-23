import 'package:get_it/get_it.dart';

import 'core/config/get_platform.dart';
import 'core/db/paths.dart';
import 'features/settings/model/settings_model.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeServiceLocator() async {
  // app initializations
  sl.registerSingleton<PT>(PlatformInfo.getCurrentPlatformType());
  sl.registerSingleton<AppDir>(AppDir());
  sl.registerSingleton<AppSettings>(AppSettings());
}
