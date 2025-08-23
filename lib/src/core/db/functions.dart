import 'package:hive_ce/hive.dart';

import '../../features/settings/model/settings_model.dart';
import '../../features/settings/model/theme/theme_model.dart';
import 'hive.dart';

class HiveFuntions {
  static void registerHiveAdepters() {
    Hive.registerAdapter(ThemeProfileAdapter());
    Hive.registerAdapter(AppSettingsAdapter());
  }

  static Future<void> openAllBoxes() async {
    await Hive.openBox<ThemeProfile>(BoxNames.themeProfile);
    await Hive.openBox<AppSettings>(BoxNames.appSettings);
  }

  static Future<void> closeAllBoxes() async {
    await Boxes.themeProfile.close();
    await Boxes.appSettings.close();
  }

  static Future<void> clearAllBoxes() async {
    await Boxes.themeProfile.clear();
    await Boxes.appSettings.clear();
  }

  static Future<void> deleteAllBoxes() async {
    await Hive.deleteBoxFromDisk(BoxNames.themeProfile);
    await Hive.deleteBoxFromDisk(BoxNames.appSettings);
  }
}
