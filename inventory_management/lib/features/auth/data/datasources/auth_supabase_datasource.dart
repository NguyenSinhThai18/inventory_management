import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/database/supabase_service.dart';

class AuthSupabaseDatasource {
  Future<void> saveUser(User user) async {
    final existingUser = await SupabaseService.client
        .from('users')
        .select()
        .eq('email', user.email!)
        .maybeSingle();

    if (existingUser != null) {
      return;
    }

    await SupabaseService.client.from('users').insert({
      'full_name': user.displayName ?? '',

      'phone_number': '',

      'email': user.email,

      'avatar_url': user.photoURL,

      'role': 'receipt_creator',
    });
  }
}
