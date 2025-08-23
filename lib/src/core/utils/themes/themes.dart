import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_transitions/go_transitions.dart';

import '../../../features/settings/model/settings_model.dart';
import '../../../features/settings/model/theme/theme_model.dart';
import '../../config/constants.dart';
import '../../db/hive.dart';
import '../extensions/extensions.dart';

String get fontFamily =>
    Boxes.appSettings.get(appName.toCamelWord, defaultValue: AppSettings())!.fontFamily;

ThemeProfile get themeType =>
    Boxes.appSettings.get(appName.toCamelWord, defaultValue: AppSettings())!.theme;

SystemUiOverlayStyle get uiConfig => themeType.uiConfig;

const Color white = Colors.white;
const Color black = Colors.black;
const Color transparent = Colors.transparent;

const Color kPrimaryColor = Color(0xFF19478D);
const Color kSecondaryColor = Color(0xFFFF981F);
const Color kSeedColor = Color(0xFF002243);
const Color kAccentColor = Color(0xFF116778);

const pageTransitionTheme = PageTransitionsTheme(
  builders: {
    TargetPlatform.android: GoTransitions.fade,
    TargetPlatform.iOS: GoTransitions.fade,
    TargetPlatform.macOS: GoTransitions.fade,
    TargetPlatform.windows: GoTransitions.fade,
    TargetPlatform.linux: GoTransitions.fade,
  },
);

const defaultGradient = LinearGradient(
  colors: [Color(0xFF5DC095), Color(0xFF1692B6), Color(0xFF2F73B9)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
