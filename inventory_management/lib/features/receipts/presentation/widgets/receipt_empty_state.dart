import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

class ReceiptEmptyState extends StatelessWidget {
  const ReceiptEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(24),

        border: Border.all(color: Colors.grey.shade200),
      ),

      child: Column(
        children: [
          Icon(Icons.receipt_long, size: 72, color: Colors.grey.shade400),

          const SizedBox(height: 16),

          Text(
            lang.receipts,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          Text(
            lang.receiptTableComingSoon,
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
