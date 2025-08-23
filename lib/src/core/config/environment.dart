import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Environment {
  static String get fileName => 'dotenv';

  static String get googleMapKey => dotenv.env['GOOGLE_MAP_KEY'] ?? 'Google Map Key Not Found';
}
