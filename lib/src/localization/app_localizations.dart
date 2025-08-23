import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en'),
  ];

  /// Car Route
  ///
  /// In en, this message translates to:
  /// **'Car Route'**
  String get appTitle;

  /// Home
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Settings
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Basic
  ///
  /// In en, this message translates to:
  /// **'Basic'**
  String get basic;

  /// Advanced
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get advanced;

  /// Performance Overlay
  ///
  /// In en, this message translates to:
  /// **'Performance Overlay'**
  String get performanceOverlay;

  /// Delete Database
  ///
  /// In en, this message translates to:
  /// **'Delete Database'**
  String get deleteDatabase;

  /// View Database
  ///
  /// In en, this message translates to:
  /// **'View Database'**
  String get viewDatabase;

  /// URL Config
  ///
  /// In en, this message translates to:
  /// **'URL Config'**
  String get urlConfig;

  /// Theme
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// System Default
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// Light
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// Dark
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// Switch to Dark Theme
  ///
  /// In en, this message translates to:
  /// **'Switch to Dark Theme'**
  String get switchToDarkTheme;

  /// Switch to Light Theme
  ///
  /// In en, this message translates to:
  /// **'Switch to Light Theme'**
  String get switchToLightTheme;

  /// Language
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// English
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Bengali
  ///
  /// In en, this message translates to:
  /// **'Bengali'**
  String get bengali;

  /// Select Language
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// Date Format
  ///
  /// In en, this message translates to:
  /// **'Date Format'**
  String get dateFormat;

  /// Time Format
  ///
  /// In en, this message translates to:
  /// **'Time Format'**
  String get timeFormat;

  /// Currency Format
  ///
  /// In en, this message translates to:
  /// **'Currency Format'**
  String get currencyFormat;

  /// Signout
  ///
  /// In en, this message translates to:
  /// **'Signout'**
  String get signout;

  /// About
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// We are Under Maintenance
  ///
  /// In en, this message translates to:
  /// **'We are Under Maintenance'**
  String get weAreUnderMaintenance;

  /// We will be back soon!
  ///
  /// In en, this message translates to:
  /// **'We will be back soon!'**
  String get weWillBeBackSoon;

  /// Contact with Admin
  ///
  /// In en, this message translates to:
  /// **'Contact with Admin'**
  String get contactWithAdmin;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['bn', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
