part of 'settings_model.dart';

extension SettingExtension on AppSettings {
  AppSettings copyWith({
    bool? firstRun,
    DateTime? firstRunDateTime,
    String? fontFamily,
    ThemeProfile? theme,
  }) => AppSettings()
    ..firstRun = firstRun ?? this.firstRun
    ..firstRunDateTime = firstRunDateTime ?? this.firstRunDateTime
    ..fontFamily = fontFamily ?? this.fontFamily
    ..theme = theme ?? this.theme;
}
