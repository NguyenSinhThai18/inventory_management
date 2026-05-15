import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

enum ReceiptType { inventory }

class ReceiptTypeDialog extends StatelessWidget {
  const ReceiptTypeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),

      child: Container(
        width: 520,
        padding: const EdgeInsets.all(28),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              AppLocalizations.of(context)!.chooseReceiptType,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              AppLocalizations.of(context)!.chooseReceiptTypeDescription,
              style: TextStyle(color: Colors.grey.shade600),
            ),

            const SizedBox(height: 28),

            _ReceiptTypeCard(
              icon: Icons.inventory_2_rounded,

              title: AppLocalizations.of(context)!.inventoryReceipt,

              description:
                  AppLocalizations.of(context)!.inventoryReceiptDescription,

              onTap: () {
                Navigator.pop(context, ReceiptType.inventory);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ReceiptTypeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _ReceiptTypeCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,

      borderRadius: BorderRadius.circular(24),

      child: InkWell(
        borderRadius: BorderRadius.circular(24),

        onTap: onTap,

        child: Container(
          padding: const EdgeInsets.all(24),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),

            border: Border.all(color: Colors.grey.shade200),
          ),

          child: Row(
            children: [
              Container(
                width: 72,
                height: 72,

                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),

                  borderRadius: BorderRadius.circular(20),
                ),

                child: Icon(icon, size: 36, color: const Color(0xFF2563EB)),
              ),

              const SizedBox(width: 20),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      description,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),

              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
