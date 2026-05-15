import 'package:flutter/material.dart';
import 'package:inventory_management/features/receipts/domain/models/receipt_detail_model.dart';

class ReceiptDocumentTopSection extends StatelessWidget {
  final ReceiptDetailModel receipt;

  const ReceiptDocumentTopSection({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Đơn vị:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      receipt.companyName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Text(
                    'Bộ phận:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      receipt.departmentName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
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
            Text(
              '(Ban hành theo Thông tư số 200/2014/TT-BTC',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 8),
            Text(
              'Ngày 22 tháng 12 năm 2014 của Bộ Tài chính)',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
