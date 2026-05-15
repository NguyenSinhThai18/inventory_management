import 'supabase_service.dart';

Future<void> testConnection() async {
  final result = await SupabaseService.client.from('users').select();

  print(result);
}
