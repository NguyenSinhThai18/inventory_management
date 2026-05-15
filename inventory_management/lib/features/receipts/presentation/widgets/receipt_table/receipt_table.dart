import 'package:flutter/material.dart';

import '../../../domain/models/receipt_list_item_model.dart';
import 'receipt_data_table.dart';
import 'receipt_table_pagination.dart';

class ReceiptTable extends StatefulWidget {
  final List<ReceiptListItemModel> receipts;

  const ReceiptTable({super.key, required this.receipts});

  @override
  State<ReceiptTable> createState() => _ReceiptTableState();
}

class _ReceiptTableState extends State<ReceiptTable> {
  static const int pageSize = 10;

  int currentPage = 1;

  List<ReceiptListItemModel> get paginatedReceipts {
    final start = (currentPage - 1) * pageSize;

    final end = (start + pageSize).clamp(0, widget.receipts.length);

    return widget.receipts.sublist(start, end);
  }

  int get totalPages {
    return (widget.receipts.length / pageSize).ceil();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(24),

        border: Border.all(color: Colors.grey.shade200),
      ),

      child: Column(
        children: [
          ReceiptDataTable(receipts: paginatedReceipts),

          Divider(height: 1, color: Colors.grey.shade200),

          ReceiptTablePagination(
            currentPage: currentPage,

            totalPages: totalPages,

            pageSize: pageSize,

            totalItems: widget.receipts.length,

            onPageChanged: (page) {
              setState(() {
                currentPage = page;
              });
            },
          ),
        ],
      ),
    );
  }
}
