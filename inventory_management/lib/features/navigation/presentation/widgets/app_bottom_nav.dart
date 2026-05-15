import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;

  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return NavigationBar(
      selectedIndex: currentIndex,

      onDestinationSelected: onTap,

      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.dashboard),
          label: l10n.dashboard,
        ),

        NavigationDestination(
          icon: const Icon(Icons.receipt_long),
          label: l10n.receipts,
        ),

        NavigationDestination(
          icon: const Icon(Icons.inventory_2),
          label: l10n.products,
        ),

        NavigationDestination(
          icon: const Icon(Icons.person),
          label: l10n.profile,
        ),
      ],
    );
  }
}
