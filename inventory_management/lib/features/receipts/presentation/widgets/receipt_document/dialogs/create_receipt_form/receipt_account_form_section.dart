import 'package:flutter/material.dart';
import 'package:inventory_management/features/receipts/presentation/widgets/receipt_document/dialogs/create_receipt_form/receipt_form_inputs.dart';

class ReceiptAccountFormSection extends StatelessWidget {
  final TextEditingController receiptNumberController;
  final TextEditingController debitAccountController;
  final TextEditingController creditAccountController;

  const ReceiptAccountFormSection({
    super.key,
    required this.receiptNumberController,
    required this.debitAccountController,
    required this.creditAccountController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(child: SizedBox()),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Số:', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 12),
              SizedBox(
                width: 180,
                child: LineInput(controller: receiptNumberController),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 180,
          child: Column(
            children: [
              LabelInputRow(label: 'Nợ', controller: debitAccountController),
              const SizedBox(height: 16),
              LabelInputRow(label: 'Có', controller: creditAccountController),
            ],
          ),
        ),
      ],
    );
  }
}
