import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';

class ReceiptSearchField extends StatelessWidget {
  final TextEditingController controller;

  const ReceiptSearchField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return TextField(
      controller: controller,

      decoration: InputDecoration(
        hintText: lang.searchReceiptHint,

        prefixIcon: const Icon(Icons.search),
      ),
    );
  }
}
