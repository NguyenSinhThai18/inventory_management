import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/responsive/responsive.dart';
import '../providers/auth_provider.dart';
import '../widgets/branding_section.dart';
import '../widgets/login_card.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    Future<void> onLogin() async {
      try {
        await ref.read(authProvider.notifier).login();

        if (!context.mounted) {
          return;
        }

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Login success')));
      } catch (_) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Login failed')));
      }
    }

    return Scaffold(
      body: Responsive.isDesktop(context)
          ? Row(
              children: [
                const Expanded(child: BrandingSection()),
                Expanded(
                  child: LoginCard(
                    isLoading: authState.isLoading,
                    onLogin: onLogin,
                  ),
                ),
              ],
            )
          : LoginCard(isLoading: authState.isLoading, onLogin: onLogin),
    );
  }
}
