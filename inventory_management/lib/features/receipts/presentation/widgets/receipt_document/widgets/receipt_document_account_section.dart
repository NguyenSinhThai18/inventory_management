import 'package:flutter/material.dart';
import 'package:inventory_management/features/receipts/domain/models/receipt_detail_model.dart';

class ReceiptDocumentAccountSection extends StatelessWidget {
  final ReceiptDetailModel receipt;

  const ReceiptDocumentAccountSection({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Stack(
        children: [
          // ================= SỐ Ở GIỮA =================
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Số:', style: TextStyle(fontSize: 18)),

                const SizedBox(width: 12),

                Text(
                  receipt.receiptNumber,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // ================= NỢ / CÓ =================
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              width: 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nợ ${receipt.debitAccount ?? ''}',
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Có ${receipt.creditAccount ?? ''}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
