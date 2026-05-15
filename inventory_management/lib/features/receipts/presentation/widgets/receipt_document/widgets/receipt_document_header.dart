import 'package:flutter/material.dart';

class ReceiptDocumentHeader extends StatelessWidget {
  final String title;
  final String primaryActionLabel;
  final IconData primaryActionIcon;
  final VoidCallback? onPrimaryAction;
  final String? secondaryActionLabel;
  final VoidCallback? onSecondaryAction;

  const ReceiptDocumentHeader({
    super.key,
    this.title = 'Receipt Preview',
    this.primaryActionLabel = 'Print',
    this.primaryActionIcon = Icons.print,
    this.onPrimaryAction,
    this.secondaryActionLabel,
    this.onSecondaryAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      padding: const EdgeInsets.symmetric(horizontal: 28),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Row(
        children: [
          Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const Spacer(),
          if (secondaryActionLabel != null) ...[
            OutlinedButton(
              onPressed: onSecondaryAction,
              child: Text(secondaryActionLabel!),
            ),
            const SizedBox(width: 12),
          ],
          FilledButton.icon(
            onPressed: onPrimaryAction,
            icon: Icon(primaryActionIcon),
            label: Text(primaryActionLabel),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
