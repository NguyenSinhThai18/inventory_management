import 'package:flutter/material.dart';
import 'package:inventory_management/core/utils/number_to_vietnamese.dart';
import 'package:inventory_management/features/receipts/domain/models/receipt_detail_model.dart';

class ReceiptDocumentSummarySection extends StatelessWidget {
  final ReceiptDetailModel receipt;

  const ReceiptDocumentSummarySection({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              '- Tổng số tiền (viết bằng chữ):',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                NumberToVietnamese.convert(receipt.totalAmount.toInt()),
                style: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            const Text(
              '- Số chứng từ gốc kèm theo:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(width: 8),
            Text(
              '${receipt.attachedDocumentsCount}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        const SizedBox(height: 36),
        Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Ngày ', style: TextStyle(fontSize: 16)),

              Text('${receipt.signedAt?.day ?? ''}'),

              const Text(' tháng '),

              Text('${receipt.signedAt?.month ?? ''}'),

              const Text(' năm '),

              Text('${receipt.signedAt?.year ?? ''}'),
            ],
          ),
        ),
      ],
    );
  }
}
