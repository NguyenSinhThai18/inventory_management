import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/receipt_provider.dart';
import '../widgets/receipt_action_bar/receipt_action_bar.dart';
import '../widgets/receipt_document/dialogs/receipt_create_dialog.dart';
import '../widgets/receipt_table/receipt_table.dart';

class ReceiptsPage extends ConsumerStatefulWidget {
  const ReceiptsPage({super.key});

  @override
  ConsumerState<ReceiptsPage> createState() => _ReceiptsPageState();
}

class _ReceiptsPageState extends ConsumerState<ReceiptsPage> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final receiptsAsync = ref.watch(receiptsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          ReceiptActionBar(
            searchController: searchController,

            onFilter: () {
              debugPrint('filter');
            },

            onUpload: () {
              debugPrint('upload');
            },

            onScan: () {
              debugPrint('scan');
            },

            onCreate: () async {
              await showDialog<void>(
                context: context,
                builder: (_) => const ReceiptCreateDialog(),
              );
            },
          ),

          const SizedBox(height: 24),

          receiptsAsync.when(
            data: (receipts) {
              return ReceiptTable(receipts: receipts);
            },

            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(40),

                child: CircularProgressIndicator(),
              ),
            ),

            error: (error, stackTrace) {
              return Container(
                padding: const EdgeInsets.all(24),

                child: Text(error.toString()),
              );
            },
          ),
        ],
      ),
    );
  }
}
