import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static SupabaseClient get client => _client ?? Supabase.instance.client;
  static SupabaseClient? _client;

  static void setClientForTesting(SupabaseClient client) {
    _client = client;
  }

  static void clearTestingClient() {
    _client = null;
  }
}
