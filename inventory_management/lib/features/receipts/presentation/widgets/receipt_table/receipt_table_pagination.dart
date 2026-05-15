import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';

class ReceiptTablePagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final int pageSize;
  final int totalItems;

  final ValueChanged<int> onPageChanged;

  const ReceiptTablePagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
    required this.totalItems,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    final start = totalItems == 0 ? 0 : (currentPage - 1) * pageSize + 1;
    final end = (currentPage * pageSize).clamp(0, totalItems);

    return Padding(
      padding: const EdgeInsets.all(20),

      child: Row(
        children: [
          Text(lang.receiptTableShowingRange(start, end, totalItems)),

          const Spacer(),

          IconButton(
            onPressed: currentPage == 1
                ? null
                : () {
                    onPageChanged(currentPage - 1);
                  },

            icon: const Icon(Icons.chevron_left),
          ),

          ...List.generate(totalPages, (index) {
            final page = index + 1;

            final selected = currentPage == page;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),

              child: InkWell(
                borderRadius: BorderRadius.circular(12),

                onTap: () {
                  onPageChanged(page);
                },

                child: Container(
                  width: 40,

                  height: 40,

                  decoration: BoxDecoration(
                    color: selected
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,

                    borderRadius: BorderRadius.circular(12),
                  ),

                  alignment: Alignment.center,

                  child: Text(
                    '$page',

                    style: TextStyle(
                      color: selected ? Colors.white : null,

                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          }),

          IconButton(
            onPressed: currentPage == totalPages
                ? null
                : () {
                    onPageChanged(currentPage + 1);
                  },

            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
