import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/models/receipt_list_item_model.dart';
import 'receipt_view_button.dart';

DataRow buildReceiptRow(BuildContext context, ReceiptListItemModel receipt) {
  return DataRow(
    cells: [
      DataCell(Text(receipt.receiptNumber)),

      DataCell(Text(DateFormat('dd/MM/yyyy').format(receipt.receiptDate))),

      DataCell(Text(receipt.warehouseName)),

      DataCell(Text(receipt.deliveredBy)),

      DataCell(
        Text(
          NumberFormat.currency(
            locale: 'vi_VN',
            symbol: '₫',
          ).format(receipt.totalAmount),
        ),
      ),

      DataCell(ReceiptViewButton(receiptId: receipt.id)),
    ],
  );
}
