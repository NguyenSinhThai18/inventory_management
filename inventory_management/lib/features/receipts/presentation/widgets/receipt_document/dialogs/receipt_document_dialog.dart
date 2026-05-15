import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management/features/receipts/presentation/providers/receipt_detail_provider.dart';
import 'package:inventory_management/features/receipts/presentation/widgets/receipt_document/widgets/receipt_document_header.dart';
import 'package:inventory_management/features/receipts/presentation/widgets/receipt_document/widgets/receipt_document_paper.dart';

class ReceiptDocumentDialog extends ConsumerWidget {
  final String receiptId;

  const ReceiptDocumentDialog({super.key, required this.receiptId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final receiptAsync = ref.watch(receiptDetailProvider(receiptId));

    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      backgroundColor: Colors.transparent,
      child: Container(
        width: 1100,
        height: MediaQuery.of(context).size.height * 0.92,
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          children: [
            const ReceiptDocumentHeader(),
            Expanded(
              child: receiptAsync.when(
                data: (receipt) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(28),
                    child: Center(
                      child: ReceiptDocumentPaper(receipt: receipt),
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) {
                  return Center(child: Text(error.toString()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
