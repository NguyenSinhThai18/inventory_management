import 'package:flutter/material.dart';
import 'package:inventory_management/core/utils/number_to_vietnamese.dart';
import 'package:inventory_management/features/receipts/presentation/widgets/receipt_document/dialogs/create_receipt_form/receipt_form_inputs.dart';

class ReceiptSummaryFormSection extends StatelessWidget {
  final double totalAmount;
  final TextEditingController attachedDocumentsController;
  final TextEditingController signedDateController;
  final FocusNode? attachedDocumentsFocusNode;

  const ReceiptSummaryFormSection({
    super.key,
    required this.totalAmount,
    required this.attachedDocumentsController,
    required this.signedDateController,
    this.attachedDocumentsFocusNode,
  });

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
                NumberToVietnamese.convert(totalAmount.toInt()),
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
            SizedBox(
              width: 80,
              child: LineInput(
                controller: attachedDocumentsController,
                focusNode: attachedDocumentsFocusNode,
              ),
            ),
          ],
        ),
        const SizedBox(height: 36),

        Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Ngày ký:', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              SizedBox(
                width: 170,
                child: DateLineInput(controller: signedDateController),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
