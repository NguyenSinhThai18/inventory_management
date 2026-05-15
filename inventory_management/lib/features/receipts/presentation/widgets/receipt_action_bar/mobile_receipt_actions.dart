import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';
import 'receipt_action_button.dart';
import 'receipt_search_field.dart';

class MobileReceiptActions extends StatelessWidget {
  final TextEditingController searchController;

  final VoidCallback onFilter;
  final VoidCallback onUpload;
  final VoidCallback onScan;

  const MobileReceiptActions({
    super.key,
    required this.searchController,
    required this.onFilter,
    required this.onUpload,
    required this.onScan,
  });

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return Column(
      children: [
        ReceiptSearchField(controller: searchController),

        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: ReceiptActionButton(
                icon: Icons.filter_alt_outlined,

                label: lang.filter,

                onTap: onFilter,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: ReceiptActionButton(
                icon: Icons.upload_file,

                label: lang.upload,

                onTap: onUpload,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: ReceiptActionButton(
                icon: Icons.document_scanner_outlined,

                label: lang.scan,

                onTap: onScan,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
