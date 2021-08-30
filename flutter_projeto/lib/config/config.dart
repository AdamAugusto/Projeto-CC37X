// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String get key => _get('ANDROID_MAPS_APIKEY');

  static String _get(String name) => DotEnv().env[name] ?? '';
}
