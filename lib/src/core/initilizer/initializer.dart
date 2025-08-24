import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import '../../injector.dart';
import '../config/environment.dart';
import '../config/get_platform.dart';
import '../db/init.dart';
import '../shared/error_view/error_view.dart';
import '../utils/logger/logger_helper.dart';

String? googleMapLightStyle;
String? googleMapDarkStyle;

class Initializer {
  Initializer._();

  static void init(VoidCallback runApp) {
    ErrorWidget.builder = (errorDetails) {
      return AppErrorView(message: errorDetails.exceptionAsString());
    };

    runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        FlutterError.onError = (details) {
          FlutterError.dumpErrorToConsole(details);
          log.i(details.stack.toString());
        };

        // Native Slpash
        FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

        // Initialize Services
        await _initServices();

        // for temporary in development mode
        // await sl<ApiClient>().signout();

        // Remove Native Slpash
        FlutterNativeSplash.remove();
        runApp();
      },
      (error, stack) {
        log.i('runZonedGuarded: ${error.toString()}');
      },
    );
  }

  static Future<void> _initServices() async {
    try {
      _initScreenPreference();
      await dotenv.load(fileName: Environment.fileName);
      await initializeServiceLocator();
      _configEasyLoading();
      await openDB();
      await initAppDatum();
      await _initMapStyles();
      if (sl<PT>().isWeb) setUrlStrategy(PathUrlStrategy());
    } catch (err) {
      rethrow;
    }
  }

  static void _initScreenPreference() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  static void _configEasyLoading() => EasyLoading.instance
    ..dismissOnTap = false
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.black
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle;

  static Future<void> _initMapStyles() async {
    await Future.wait([
      rootBundle
          .loadString('assets/json/map-light-mode.json')
          .then((ls) => googleMapLightStyle = ls),
      rootBundle.loadString('assets/json/map-dark-mode.json').then((ds) => googleMapDarkStyle = ds),
    ]);
  }
}
