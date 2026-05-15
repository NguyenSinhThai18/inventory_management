import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/responsive/responsive.dart';
import '../../../../l10n/app_localizations.dart';
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
        final success = await ref.read(authProvider.notifier).login();

        if (!context.mounted) {
          return;
        }

        if (!success) {
          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.loginSuccess)),
        );

        context.go('/dashboard');
      } catch (_) {
        if (!context.mounted) {
          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.loginFailed)),
        );
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
