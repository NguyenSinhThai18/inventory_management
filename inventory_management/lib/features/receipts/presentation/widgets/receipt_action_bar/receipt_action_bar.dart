import 'package:flutter/material.dart';

import '../../../../../core/responsive/responsive.dart';
import '../../../../../l10n/app_localizations.dart';
import 'mobile_receipt_actions.dart';
import 'receipt_action_button.dart';
import 'receipt_search_field.dart';

class ReceiptActionBar extends StatelessWidget {
  final TextEditingController searchController;

  final VoidCallback onFilter;
  final VoidCallback onUpload;
  final VoidCallback onScan;
  final VoidCallback onCreate;

  const ReceiptActionBar({
    super.key,
    required this.searchController,
    required this.onFilter,
    required this.onUpload,
    required this.onScan,
    required this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    final isMobile = Responsive.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Row(
          children: [
            FilledButton.icon(
              onPressed: onCreate,

              icon: const Icon(Icons.add),

              label: Text(lang.create),
            ),
          ],
        ),

        const SizedBox(height: 24),

        if (isMobile)
          MobileReceiptActions(
            searchController: searchController,

            onFilter: onFilter,

            onUpload: onUpload,

            onScan: onScan,
          )
        else
          Row(
            children: [
              Expanded(child: ReceiptSearchField(controller: searchController)),

              const SizedBox(width: 16),

              ReceiptActionButton(
                icon: Icons.filter_alt_outlined,

                label: lang.filter,

                onTap: onFilter,
              ),

              const SizedBox(width: 12),

              ReceiptActionButton(
                icon: Icons.upload_file,

                label: lang.upload,

                onTap: onUpload,
              ),

              const SizedBox(width: 12),

              ReceiptActionButton(
                icon: Icons.document_scanner_outlined,

                label: lang.scan,

                onTap: onScan,
              ),
            ],
          ),
      ],
    );
  }
}
