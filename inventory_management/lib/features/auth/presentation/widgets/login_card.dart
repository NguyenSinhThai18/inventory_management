import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../localization/presentation/widgets/language_switch.dart';

class LoginCard extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onLogin;

  const LoginCard({super.key, required this.isLoading, required this.onLogin});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Container(
          width: 420,
          padding: const EdgeInsets.all(36),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: const [BoxShadow(blurRadius: 30, color: Colors.black12)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.centerRight,
                child: LanguageSwitch(),
              ),

              const SizedBox(height: 28),

              const Icon(
                Icons.inventory_2_rounded,
                size: 72,
                color: Color(0xFF2563EB),
              ),

              const SizedBox(height: 20),

              Text(
                lang.welcomeBack,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Text(lang.loginDescription, textAlign: TextAlign.center),

              const SizedBox(height: 36),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: isLoading ? null : onLogin,
                  child: isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(lang.continueWithGoogle),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
