import 'package:flutter/material.dart';
import 'package:inventory_management/features/receipts/domain/models/receipt_detail_model.dart';

class ReceiptDocumentSignatureSection extends StatelessWidget {
  final ReceiptDetailModel receipt;

  const ReceiptDocumentSignatureSection({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SignatureColumn(
          title: 'Người lập phiếu',
          name: receipt.createdByName,
          boldName: true,
        ),
        _SignatureColumn(
          title: 'Người giao hàng',
          name: receipt.deliveredBy,
        ),
        _SignatureColumn(
          title: 'Thủ kho',
          name: receipt.warehouseKeeperName,
        ),
        _SignatureColumn(
          title: 'Kế toán trưởng',
          subtitleLines: const [
            '(Hoặc bộ phận',
            'có nhu cầu nhập)',
            '(Ký, họ tên)',
          ],
          name: receipt.chiefAccountantName,
          nameTopSpacing: 58,
        ),
      ],
    );
  }
}

class _SignatureColumn extends StatelessWidget {
  final String title;
  final List<String> subtitleLines;
  final String name;
  final bool boldName;
  final double nameTopSpacing;

  const _SignatureColumn({
    required this.title,
    required this.name,
    this.subtitleLines = const ['(Ký, họ tên)'],
    this.boldName = false,
    this.nameTopSpacing = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          for (final line in subtitleLines) ...[
            Text(line),
            if (line != subtitleLines.last) const SizedBox(height: 2),
          ],
          SizedBox(height: nameTopSpacing),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: boldName ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
