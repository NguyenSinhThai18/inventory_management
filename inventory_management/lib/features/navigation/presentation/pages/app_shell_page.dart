import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/responsive/responsive.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../localization/presentation/widgets/language_switch.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/app_sidebar.dart';

class AppShellPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const AppShellPage({super.key, required this.navigationShell});

  @override
  State<AppShellPage> createState() => _AppShellPageState();
}

class _AppShellPageState extends State<AppShellPage> {
  bool isSidebarCollapsed = false;

  void _onTap(int index) {
    widget.navigationShell.goBranch(index);
  }

  String _title(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return switch (widget.navigationShell.currentIndex) {
      0 => l10n.dashboard,
      1 => l10n.receipts,
      2 => l10n.products,
      3 => l10n.profile,
      _ => l10n.dashboard,
    };
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      body: isDesktop
          ? Row(
              children: [
                AppSidebar(
                  currentIndex: widget.navigationShell.currentIndex,

                  isCollapsed: isSidebarCollapsed,

                  onToggleCollapsed: () {
                    setState(() {
                      isSidebarCollapsed = !isSidebarCollapsed;
                    });
                  },

                  onTap: _onTap,
                ),

                Expanded(
                  child: Column(
                    children: [
                      _AppHeader(
                        title: _title(context),

                        user: user,
                      ),

                      Expanded(child: widget.navigationShell),
                    ],
                  ),
                ),
              ],
            )
          : Column(
              children: [
                _AppHeader(
                  title: _title(context),

                  user: user,
                ),

                Expanded(child: widget.navigationShell),
              ],
            ),

      bottomNavigationBar: isDesktop
          ? null
          : AppBottomNav(
              currentIndex: widget.navigationShell.currentIndex,

              onTap: _onTap,
            ),
    );
  }
}

class _AppHeader extends StatelessWidget {
  final String title;
  final User? user;

  const _AppHeader({required this.title, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      padding: const EdgeInsets.symmetric(horizontal: 28),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),

      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),

          const Spacer(),

          const LanguageSwitch(),

          const SizedBox(width: 16),

          CircleAvatar(
            radius: 20,
            backgroundImage: user?.photoURL != null
                ? NetworkImage(user!.photoURL!)
                : null,
          ),
        ],
      ),
    );
  }
}
