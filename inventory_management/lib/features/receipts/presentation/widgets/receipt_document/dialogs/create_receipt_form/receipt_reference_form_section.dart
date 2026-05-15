import 'package:flutter/material.dart';
import 'package:inventory_management/features/receipts/presentation/widgets/receipt_document/dialogs/create_receipt_form/receipt_form_inputs.dart';

class ReceiptReferenceFormSection extends StatelessWidget {
  final TextEditingController deliveredByController;
  final TextEditingController referenceTypeController;
  final TextEditingController referenceNumberController;
  final TextEditingController referenceDateController;
  final TextEditingController supplierController;
  final TextEditingController warehouseController;
  final TextEditingController locationController;

  const ReceiptReferenceFormSection({
    super.key,
    required this.deliveredByController,
    required this.referenceTypeController,
    required this.referenceNumberController,
    required this.referenceDateController,
    required this.supplierController,
    required this.warehouseController,
    required this.locationController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelInputRow(
          label: '- Họ và tên người giao:',
          controller: deliveredByController,
        ),
        const SizedBox(height: 18),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 12,
          children: [
            const Text('- Theo', style: TextStyle(fontSize: 18)),
            SizedBox(
              width: 120,
              child: LineInput(controller: referenceTypeController),
            ),
            const Text('số', style: TextStyle(fontSize: 18)),
            SizedBox(
              width: 120,
              child: LineInput(controller: referenceNumberController),
            ),
            ReceiptDatePartsInput(
              controller: referenceDateController,
              firstLabel: 'ngày',
            ),
            const Text('của', style: TextStyle(fontSize: 18)),
            SizedBox(
              width: 240,
              child: LineInput(controller: supplierController),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            const Text('- Nhập tại kho', style: TextStyle(fontSize: 18)),
            const SizedBox(width: 8),
            Expanded(child: LineInput(controller: warehouseController)),
            const SizedBox(width: 8),
            const Text('địa điểm', style: TextStyle(fontSize: 18)),
            const SizedBox(width: 8),
            Expanded(child: LineInput(controller: locationController)),
          ],
        ),
      ],
    );
  }
}
