import 'package:flutter/material.dart';
import 'package:inventory_management/features/receipts/presentation/widgets/receipt_document_dialog.dart';

import '../../../../../core/responsive/responsive.dart';
import '../../../../../l10n/app_localizations.dart';

class ReceiptViewButton extends StatelessWidget {
  final String receiptId;

  const ReceiptViewButton({super.key, required this.receiptId});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final lang = AppLocalizations.of(context)!;

    return FilledButton.icon(
      onPressed: () {
        showDialog(
          context: context,

          builder: (_) => ReceiptDocumentDialog(receiptId: receiptId),
        );
      },

      icon: const Icon(Icons.visibility),

      label: Text(isMobile ? '' : lang.receiptTableView),
    );
  }
}
