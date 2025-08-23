import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../config/constants.dart';
import '../../../config/size.dart';
import '../themes.dart';

const darkUiConfig = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.light,
  systemNavigationBarColor: _backgroundColor,
  systemNavigationBarIconBrightness: Brightness.light,
);

const darkPrimaryColor = kPrimaryColor;
const _headLineTextColor = Colors.white;
const _iconColorSecondary = kPrimaryColor;
const _backgroundColor = Color(0xFF181A20);
const _bodyTextColor = Colors.white;
const _unselectedColor = Colors.blueGrey;
const _titleTextColor = Colors.white;
const _primaryLightColor = kPrimaryColor;
const _cardBackgroundColor = Color.fromARGB(255, 0, 0, 0);
const _scaffoldBackgroundColor = Color(0xFF181A20);
const _floatingActionButtonColor = kPrimaryColor;
final _shadowColor = kPrimaryColor.withValues(alpha: 0.3);

final darkTheme = ThemeData(
  useMaterial3: true,
  cardTheme: _cardTheme,
  textTheme: _textTheme,
  fontFamily: fontFamily,
  radioTheme: _radioTheme,
  shadowColor: _shadowColor,
  appBarTheme: _appBarTheme,
  tabBarTheme: _tabBarTheme,
  dialogTheme: _dialogTheme,
  switchTheme: _switchTheme,
  tooltipTheme: _tooltipTheme,
  brightness: Brightness.dark,
  listTileTheme: _listTileTheme,
  snackBarTheme: _snackBarTheme,
  primaryColor: darkPrimaryColor,
  cardColor: _cardBackgroundColor,
  dividerTheme: _dividerTheme,
  unselectedWidgetColor: _unselectedColor,
  bottomNavigationBarTheme: _bottomNavBar,
  secondaryHeaderColor: _primaryLightColor,
  textSelectionTheme: _textSelectionTheme,
  pageTransitionsTheme: pageTransitionTheme,
  outlinedButtonTheme: _outlinedButtonTheme,
  elevatedButtonTheme: _elevatedButtonTheme,
  inputDecorationTheme: _darkInputDecorationTheme,
  progressIndicatorTheme: _progressIndicatorTheme,
  scaffoldBackgroundColor: _scaffoldBackgroundColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  floatingActionButtonTheme: _floatingActionButtonTheme,
  iconTheme: const IconThemeData(color: _iconColorSecondary),
  chipTheme: _chipTheme,
  primaryIconTheme: const IconThemeData(color: darkPrimaryColor),
  drawerTheme: const DrawerThemeData(backgroundColor: Color(0xFF0D0D0E), width: 240),
);

final _chipTheme = ChipThemeData(
  backgroundColor: Colors.white,
  labelStyle: _textTheme.bodyMedium!.copyWith(color: kPrimaryColor, fontWeight: FontWeight.w600),
  padding: const EdgeInsets.symmetric(horizontal: 5),
  shape: roundedRectangleBorder30,
  side: BorderSide.none,
  labelPadding: const EdgeInsets.symmetric(horizontal: 5),
  elevation: 5.0,
  shadowColor: kPrimaryColor.withValues(alpha: 0.5),
);

final _dividerTheme = DividerThemeData(
  color: _unselectedColor.withValues(alpha: 0.4),
  thickness: 0.4,
);

final _switchTheme = SwitchThemeData(
  thumbColor: WidgetStateProperty.all(darkPrimaryColor),
  trackColor: WidgetStateProperty.all(darkPrimaryColor.withValues(alpha: 0.5)),
);

final _darkInputDecorationTheme = InputDecorationTheme(
  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
  enabledBorder: OutlineInputBorder(
    borderRadius: defaultBorderRadius,
    gapPadding: 10,
    // borderSide: const BorderSide(color: _bodyTextColor, width: 1.0),
    borderSide: BorderSide.none,
  ),
  border: OutlineInputBorder(
    borderRadius: defaultBorderRadius,
    gapPadding: 10,
    // borderSide: const BorderSide(color: _bodyTextColor, width: 1.0),
    borderSide: BorderSide.none,
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: defaultBorderRadius,
    gapPadding: 10,
    // borderSide: BorderSide(color: _bodyTextColor.withValues(alpha: 0.4), width: 1.0),
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: defaultBorderRadius,
    gapPadding: 10,
    // borderSide: const BorderSide(color: darkPrimaryColor, width: 1.3),
    borderSide: BorderSide.none,
  ),
  floatingLabelStyle: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: darkPrimaryColor,
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: defaultBorderRadius,
    gapPadding: 10,
    // borderSide: const BorderSide(color: Colors.red, width: 1.3),
    borderSide: BorderSide.none,
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: defaultBorderRadius,
    gapPadding: 10,
    // borderSide: const BorderSide(color: Colors.red, width: 1.3),
    borderSide: BorderSide.none,
  ),
  filled: true,
  fillColor: _scaffoldBackgroundColor,
  suffixIconColor: darkPrimaryColor,
  prefixIconColor: darkPrimaryColor,
  errorMaxLines: 3,
  floatingLabelBehavior: FloatingLabelBehavior.never,
);

const _textSelectionTheme = TextSelectionThemeData(
  cursorColor: darkPrimaryColor,
  selectionColor: darkPrimaryColor,
  selectionHandleColor: darkPrimaryColor,
);

final _snackBarTheme = SnackBarThemeData(
  actionTextColor: _textTheme.labelSmall!.color,
  contentTextStyle: _textTheme.labelSmall,
  backgroundColor: Colors.transparent,
  behavior: SnackBarBehavior.floating,
  shape: roundedRectangleBorder30,
  elevation: 0.0,
);

final _tabBarTheme = TabBarThemeData(
  labelColor: darkPrimaryColor,
  unselectedLabelColor: _unselectedColor,
  indicatorSize: TabBarIndicatorSize.label,
  indicator: BoxDecoration(borderRadius: borderRadius30),
  indicatorColor: _floatingActionButtonColor,
);

final _cardTheme = CardThemeData(
  shape: roundedRectangleBorder12,
  shadowColor: _shadowColor,
  color: _cardBackgroundColor,
  elevation: 0,
);

final _radioTheme = RadioThemeData(
  fillColor: WidgetStateProperty.all(darkPrimaryColor),
  overlayColor: WidgetStateProperty.all(_primaryLightColor),
);

final _listTileTheme = ListTileThemeData(shape: roundedRectangleBorder30);

final _dialogTheme = DialogThemeData(
  backgroundColor: _cardBackgroundColor,
  shape: roundedRectangleBorder30,
);

final _tooltipTheme = TooltipThemeData(
  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
  decoration: BoxDecoration(
    borderRadius: defaultBorderRadius,
    color: _floatingActionButtonColor.withValues(alpha: 0.8),
  ),
  textStyle: _textTheme.titleSmall!.copyWith(color: Colors.white),
);

final _appBarTheme = AppBarTheme(
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomRight: Radius.circular(25),
      bottomLeft: Radius.circular(25),
    ),
  ),
  shadowColor: _cardBackgroundColor,
  iconTheme: const IconThemeData(color: _iconColorSecondary),
  backgroundColor: _cardBackgroundColor,
  elevation: 0.0,
  titleTextStyle: _textTheme.titleLarge,
);

const _floatingActionButtonTheme = FloatingActionButtonThemeData(
  backgroundColor: _floatingActionButtonColor,
  foregroundColor: Colors.white,
  elevation: 0,
);

const _progressIndicatorTheme = ProgressIndicatorThemeData(
  refreshBackgroundColor: _primaryLightColor,
  circularTrackColor: _primaryLightColor,
  linearTrackColor: _primaryLightColor,
  color: darkPrimaryColor,
);

final _elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: darkPrimaryColor,
    textStyle: _textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
    foregroundColor: const Color(0xFFe2eeff),
    padding: const EdgeInsets.all(8),
    minimumSize: const Size(47, 47),
    shape: roundedRectangleBorder45,
  ),
);

final _outlinedButtonTheme = OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    foregroundColor: darkPrimaryColor,
    textStyle: _textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
    backgroundColor: _scaffoldBackgroundColor,
    padding: const EdgeInsets.all(8),
    minimumSize: const Size(47, 47),
    shape: roundedRectangleBorder45,
  ),
);

const _textTheme = TextTheme(
  titleSmall: TextStyle(fontWeight: FontWeight.w700, color: _titleTextColor),
  titleMedium: TextStyle(fontWeight: FontWeight.w700, color: _titleTextColor),
  titleLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0, color: _titleTextColor),
  labelSmall: TextStyle(color: _bodyTextColor, fontWeight: FontWeight.w700, letterSpacing: 0.7),
  labelMedium: TextStyle(color: _bodyTextColor, fontWeight: FontWeight.w700),
  labelLarge: TextStyle(color: _bodyTextColor, fontWeight: FontWeight.w700),
  bodySmall: TextStyle(color: _bodyTextColor),
  bodyMedium: TextStyle(color: _bodyTextColor),
  bodyLarge: TextStyle(color: _bodyTextColor, fontSize: 16, fontWeight: FontWeight.w700),
  headlineLarge: TextStyle(fontWeight: FontWeight.w900, color: _headLineTextColor),
);

const _bottomNavBar = BottomNavigationBarThemeData(
  backgroundColor: _cardBackgroundColor,
  unselectedItemColor: _unselectedColor,
  type: BottomNavigationBarType.fixed,
  selectedItemColor: darkPrimaryColor,
  showUnselectedLabels: true,
  showSelectedLabels: true,
  elevation: 0.0,
  selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700, color: darkPrimaryColor, fontSize: 11),
  unselectedLabelStyle: TextStyle(
    fontWeight: FontWeight.w600,
    color: _unselectedColor,
    fontSize: 11,
  ),
);

const darkGradiants = [
  [Color.fromARGB(150, 0, 85, 74), Color.fromARGB(255, 0, 85, 74)],
  [Color.fromARGB(150, 44, 50, 56), Color.fromARGB(255, 44, 50, 56)],
  [Color.fromARGB(150, 56, 101, 122), Color.fromARGB(255, 56, 101, 122)],
  [Color.fromARGB(150, 25, 133, 167), Color.fromARGB(255, 25, 133, 167)],
  [Color.fromARGB(150, 20, 59, 119), Color.fromARGB(255, 20, 59, 119)],
];
