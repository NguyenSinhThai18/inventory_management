import 'package:flutter_dotenv/flutter_dotenv.dart';

enum AppMode { supabase }

class AppConfig {
  static AppMode get mode {
    final mode = dotenv.env['APP_MODE'];

    switch (mode) {
      case 'supabase':
      default:
        return AppMode.supabase;
    }
  }

  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';

  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';
}
