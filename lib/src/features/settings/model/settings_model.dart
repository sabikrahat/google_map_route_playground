import 'dart:convert' show json;

import 'package:hive_ce/hive.dart';

import '../../../core/config/constants.dart';
import '../../../core/db/hive.dart';
import '../../../core/utils/extensions/extensions.dart';
import 'theme/theme_model.dart';

part 'settings_model.g.dart';
part 'settings_model_crud_ext.dart';
part 'settings_model_ext.dart';

@HiveType(typeId: HiveTypes.appSettings)
class AppSettings extends HiveObject {
  AppSettings();

  @HiveField(0)
  bool firstRun = true;
  @HiveField(1)
  DateTime firstRunDateTime = DateTime.now().toUtc();
  @HiveField(2)
  String fontFamily = 'Urbanist';
  @HiveField(3)
  ThemeProfile theme = ThemeProfile.system;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
    _Json.firstRun: firstRun,
    _Json.firstRunDateTime: firstRunDateTime.toIso8601String(),
    _Json.fontFamily: fontFamily,
    _Json.theme: theme.name,
  };

  factory AppSettings.fromJson(String source) => AppSettings.fromRawJson(json.decode(source));

  factory AppSettings.fromRawJson(Map<String, dynamic> json) => AppSettings()
    ..firstRun = json[_Json.firstRun] as bool
    ..firstRunDateTime = DateTime.parse(json[_Json.firstRunDateTime] as String)
    ..fontFamily = json[_Json.fontFamily] as String
    ..theme = ThemeProfile.values.firstWhere(
      (e) => e.name == json[_Json.theme] as String,
      orElse: () => ThemeProfile.light,
    );

  @override
  String toString() => toRawJson();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppSettings &&
        other.firstRunDateTime.microsecondsSinceEpoch == firstRunDateTime.microsecondsSinceEpoch;
  }

  @override
  int get hashCode => firstRunDateTime.microsecondsSinceEpoch;
}

class _Json {
  static const String firstRun = 'first_run';
  static const String firstRunDateTime = 'first_run_date_time';
  static const String fontFamily = 'font_family';
  static const String theme = 'theme';
}
