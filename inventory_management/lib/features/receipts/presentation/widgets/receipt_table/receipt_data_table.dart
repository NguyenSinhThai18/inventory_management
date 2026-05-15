import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../domain/models/receipt_list_item_model.dart';
import 'receipt_table_row.dart';

class ReceiptDataTable extends StatelessWidget {
  final List<ReceiptListItemModel> receipts;

  const ReceiptDataTable({super.key, required this.receipts});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return Scrollbar(
      thumbVisibility: true,

      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,

        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 950),

          child: DataTable(
            headingRowHeight: 60,

            dataRowMinHeight: 68,

            dataRowMaxHeight: 68,

            columnSpacing: 32,

            columns: [
              DataColumn(label: Text(lang.receiptTableReceiptNo)),

              DataColumn(label: Text(lang.receiptTableDate)),

              DataColumn(label: Text(lang.receiptTableWarehouse)),

              DataColumn(label: Text(lang.receiptTableDeliveredBy)),

              DataColumn(label: Text(lang.receiptTableTotal)),

              DataColumn(label: Text(lang.receiptTableAction)),
            ],

            rows: receipts.map((receipt) {
              return buildReceiptRow(context, receipt);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
