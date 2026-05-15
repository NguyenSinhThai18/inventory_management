import 'package:flutter/material.dart';
import 'package:inventory_management/features/receipts/presentation/widgets/receipt_document/dialogs/create_receipt_form/receipt_form_inputs.dart';

class ReceiptTopFormSection extends StatelessWidget {
  final TextEditingController companyController;
  final TextEditingController departmentController;

  const ReceiptTopFormSection({
    super.key,
    required this.companyController,
    required this.departmentController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              LabelInputRow(label: 'Đơn vị:', controller: companyController),
              const SizedBox(height: 5),
              LabelInputRow(
                label: 'Bộ phận:',
                controller: departmentController,
              ),
            ],
          ),
        ),
        const SizedBox(width: 40),
        const Column(
          children: [
            Text(
              'Mẫu số 01 - VT',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text('(Ban hành theo Thông tư số 200/2014/TT-BTC)'),
            SizedBox(height: 8),
            Text('Ngày 22 tháng 12 năm 2014 của Bộ Tài chính)'),
          ],
        ),
      ],
    );
  }
}
