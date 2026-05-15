import 'package:flutter/material.dart';
import 'package:inventory_management/features/receipts/presentation/widgets/receipt_document/dialogs/create_receipt_form/receipt_form_inputs.dart';

class ReceiptSignatureFormSection extends StatelessWidget {
  final TextEditingController createdByController;
  final TextEditingController deliveredByController;
  final TextEditingController warehouseKeeperController;
  final TextEditingController chiefAccountantController;

  const ReceiptSignatureFormSection({
    super.key,
    required this.createdByController,
    required this.deliveredByController,
    required this.warehouseKeeperController,
    required this.chiefAccountantController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SignatureInputColumn(
          title: 'Người lập phiếu',
          controller: createdByController,
        ),
        _SignatureInputColumn(
          title: 'Người giao hàng',
          controller: deliveredByController,
        ),
        _SignatureInputColumn(
          title: 'Thủ kho',
          controller: warehouseKeeperController,
        ),
        _SignatureInputColumn(
          title: 'Kế toán trưởng',
          subtitleLines: const [
            '(Hoặc bộ phận',
            'có nhu cầu nhập)',
            '(Ký, họ tên)',
          ],
          controller: chiefAccountantController,
          topSpacing: 58,
        ),
      ],
    );
  }
}

class _SignatureInputColumn extends StatelessWidget {
  final String title;
  final List<String> subtitleLines;
  final TextEditingController controller;
  final double topSpacing;

  const _SignatureInputColumn({
    required this.title,
    required this.controller,
    this.subtitleLines = const ['(Ký, họ tên)'],
    this.topSpacing = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          for (final line in subtitleLines) Text(line),
          SizedBox(height: topSpacing),
          LineInput(controller: controller, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
