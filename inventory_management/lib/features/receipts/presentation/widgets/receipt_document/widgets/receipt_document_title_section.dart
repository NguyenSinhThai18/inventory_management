import 'package:flutter/material.dart';
import 'package:inventory_management/features/receipts/domain/models/receipt_detail_model.dart';

class ReceiptDocumentTitleSection extends StatelessWidget {
  final ReceiptDetailModel receipt;

  const ReceiptDocumentTitleSection({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            'PHIẾU NHẬP KHO',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 12),
          Text(
            'Ngày ${receipt.receiptDate.day} tháng ${receipt.receiptDate.month} năm ${receipt.receiptDate.year}',
            style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
