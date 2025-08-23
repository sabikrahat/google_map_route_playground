part of 'theme_model.dart';

extension ThemeProfileExtension on ThemeProfile {
  String get label {
    switch (this) {
      case ThemeProfile.system:
        return t.systemDefault;
      case ThemeProfile.light:
        return t.light;
      case ThemeProfile.dark:
        return t.dark;
    }
  }

  String get icon {
    switch (this) {
      case ThemeProfile.system:
        return 'assets/svgs/system.svg';
      case ThemeProfile.light:
        return 'assets/svgs/light.svg';
      case ThemeProfile.dark:
        return 'assets/svgs/dark.svg';
    }
  }

  bool get isSystem => this == ThemeProfile.system;
  bool get isLight => this == ThemeProfile.light;
  bool get isDark => this == ThemeProfile.dark;

  bool get isNotSystem => !isSystem;
  bool get isNotLight => !isLight;
  bool get isNotDark => !isDark;

  bool isCoreLight(BuildContext context) =>
      isSystem
          ? context.isLightTheme
          : isLight
          ? true
          : false;

  bool isCoreDark(BuildContext context) =>
      isSystem
          ? context.isDarkTheme
          : isDark
          ? true
          : false;

  SystemUiOverlayStyle get uiConfig {
    switch (this) {
      case ThemeProfile.dark:
        return darkUiConfig;
      case ThemeProfile.light:
        return lightUiConfig;
      default:
        return lightUiConfig;
    }
  }
}
