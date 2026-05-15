import 'package:flutter/material.dart';
import 'package:inventory_management/features/receipts/domain/models/receipt_detail_model.dart';

class ReceiptDocumentReferenceSection extends StatelessWidget {
  final ReceiptDetailModel receipt;

  const ReceiptDocumentReferenceSection({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              '- Họ và tên người giao:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                receipt.deliveredBy,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 6,
          runSpacing: 12,
          children: [
            const Text('- Theo', style: TextStyle(fontSize: 18)),
            Text(
              receipt.referenceType ?? '',
              style: const TextStyle(fontSize: 18),
            ),
            const Text('số', style: TextStyle(fontSize: 18)),
            Text(
              receipt.referenceNumber ?? '',
              style: const TextStyle(fontSize: 18),
            ),
            const Text('ngày', style: TextStyle(fontSize: 18)),
            Text(
              '${receipt.referenceDate?.day ?? ''}',
              style: const TextStyle(fontSize: 18),
            ),
            const Text('tháng', style: TextStyle(fontSize: 18)),
            Text(
              '${receipt.referenceDate?.month ?? ''}',
              style: const TextStyle(fontSize: 18),
            ),
            const Text('năm', style: TextStyle(fontSize: 18)),
            Text(
              '${receipt.referenceDate?.year ?? ''}',
              style: const TextStyle(fontSize: 18),
            ),
            const Text('của', style: TextStyle(fontSize: 18)),
            Text(
              receipt.supplierName ?? '',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          '- Nhập tại kho ${receipt.warehouseName} địa điểm ${receipt.location}',
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
