import 'package:flutter/material.dart';
import 'package:inventory_management/features/receipts/presentation/widgets/receipt_document/dialogs/create_receipt_form/receipt_form_inputs.dart';

class ReceiptTitleFormSection extends StatelessWidget {
  final TextEditingController dateController;

  const ReceiptTitleFormSection({super.key, required this.dateController});

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
          ReceiptDatePartsInput(controller: dateController),
        ],
      ),
    );
  }
}
