import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

class AppSidebar extends StatelessWidget {
  final int currentIndex;
  final bool isCollapsed;
  final VoidCallback onToggleCollapsed;
  final ValueChanged<int> onTap;

  const AppSidebar({
    super.key,
    required this.currentIndex,
    required this.isCollapsed,
    required this.onToggleCollapsed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      width: isCollapsed ? 88 : 270,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Colors.grey.shade200)),
      ),

      child: Column(
        children: [
          const SizedBox(height: 18),

          Align(
            alignment: isCollapsed ? Alignment.center : Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: isCollapsed ? 0 : 14),
              child: IconButton(
                tooltip: isCollapsed ? 'Expand sidebar' : 'Collapse sidebar',
                onPressed: onToggleCollapsed,
                icon: Icon(
                  isCollapsed
                      ? Icons.keyboard_double_arrow_right_rounded
                      : Icons.keyboard_double_arrow_left_rounded,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          const CircleAvatar(
            radius: 34,
            backgroundColor: Color(0xFFEFF6FF),
            child: Icon(
              Icons.inventory_2_rounded,
              size: 34,
              color: Color(0xFF2563EB),
            ),
          ),

          const SizedBox(height: 18),

          if (!isCollapsed)
            Text(
              l10n.inventoryManager,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

          SizedBox(height: isCollapsed ? 28 : 40),

          _SidebarItem(
            title: l10n.dashboard,
            icon: Icons.dashboard,
            selected: currentIndex == 0,
            isCollapsed: isCollapsed,
            onTap: () => onTap(0),
          ),

          _SidebarItem(
            title: l10n.receipts,
            icon: Icons.receipt_long,
            selected: currentIndex == 1,
            isCollapsed: isCollapsed,
            onTap: () => onTap(1),
          ),

          _SidebarItem(
            title: l10n.products,
            icon: Icons.inventory_2,
            selected: currentIndex == 2,
            isCollapsed: isCollapsed,
            onTap: () => onTap(2),
          ),

          _SidebarItem(
            title: l10n.profile,
            icon: Icons.person,
            selected: currentIndex == 3,
            isCollapsed: isCollapsed,
            onTap: () => onTap(3),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final bool isCollapsed;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.title,
    required this.icon,
    required this.selected,
    required this.isCollapsed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final item = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isCollapsed ? 12 : 16,
        vertical: 6,
      ),
      child: Material(
        color: selected ? const Color(0xFF2563EB) : Colors.transparent,

        borderRadius: BorderRadius.circular(isCollapsed ? 16 : 18),

        child: InkWell(
          borderRadius: BorderRadius.circular(isCollapsed ? 16 : 18),

          onTap: onTap,

          child: SizedBox(
            height: 56,
            child: Row(
              mainAxisAlignment: isCollapsed
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                if (!isCollapsed) const SizedBox(width: 20),
                Icon(icon, color: selected ? Colors.white : Colors.black87),
                if (!isCollapsed) ...[
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: selected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ],
            ),
          ),
        ),
      ),
    );

    if (isCollapsed) {
      return Tooltip(
        message: title,
        waitDuration: const Duration(milliseconds: 400),
        child: item,
      );
    }

    return item;
  }
}
