import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:inventory_management/features/receipts/domain/models/receipt_detail_model.dart';
import 'package:inventory_management/features/receipts/presentation/widgets/receipt_document/widgets/receipt_document_account_section.dart';
import 'package:inventory_management/features/receipts/presentation/widgets/receipt_document/widgets/receipt_document_reference_section.dart';
import 'package:inventory_management/features/receipts/presentation/widgets/receipt_document/widgets/receipt_document_signature_section.dart';
import 'package:inventory_management/features/receipts/presentation/widgets/receipt_document/widgets/receipt_document_summary_section.dart';
import 'package:inventory_management/features/receipts/presentation/widgets/receipt_document/widgets/receipt_document_title_section.dart';
import 'package:inventory_management/features/receipts/presentation/widgets/receipt_document/widgets/receipt_document_top_section.dart';
import 'package:inventory_management/features/receipts/presentation/widgets/receipt_document/widgets/receipt_items_table.dart';

class ReceiptDocumentPaper extends StatelessWidget {
  final ReceiptDetailModel receipt;

  const ReceiptDocumentPaper({super.key, required this.receipt});

  static const double _pageWidth = 900;
  static const double _pageMinHeight = 1123;
  static const EdgeInsets _pagePadding = EdgeInsets.fromLTRB(32, 60, 32, 60);
  static const int _firstPageItemCount = 6;
  static const int _middlePageItemCount = 14;
  static const int _lastPageItemCount = 6;

  @override
  Widget build(BuildContext context) {
    final pages = _buildPages();

    return Column(
      children: [
        for (var i = 0; i < pages.length; i++) ...[
          _ReceiptDocumentPage(child: pages[i]),
          if (i != pages.length - 1) const SizedBox(height: 28),
        ],
      ],
    );
  }

  List<Widget> _buildPages() {
    final chunks = _splitItems();
    final isSinglePage = chunks.length == 1;

    return [
      _buildFirstPage(items: chunks.first, isLastPage: isSinglePage),
      for (var i = 1; i < chunks.length; i++)
        _buildContinuationPage(
          items: chunks[i],
          isLastPage: i == chunks.length - 1,
        ),
    ];
  }

  Widget _buildFirstPage({
    required List<ReceiptItemModel> items,
    required bool isLastPage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReceiptDocumentTopSection(receipt: receipt),
        const SizedBox(height: 30),
        ReceiptDocumentTitleSection(receipt: receipt),
        const SizedBox(height: 12),
        ReceiptDocumentAccountSection(receipt: receipt),
        const SizedBox(height: 12),
        ReceiptDocumentReferenceSection(receipt: receipt),
        const SizedBox(height: 30),
        ReceiptItemsTable(
          receipt: receipt,
          items: items,
          showTotal: isLastPage,
        ),
        if (isLastPage) ..._buildFooterSections(),
      ],
    );
  }

  Widget _buildContinuationPage({
    required List<ReceiptItemModel> items,
    required bool isLastPage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReceiptItemsTable(
          receipt: receipt,
          items: items,
          showTotal: isLastPage,
        ),
        if (isLastPage) ..._buildFooterSections(),
      ],
    );
  }

  List<Widget> _buildFooterSections() {
    return [
      const SizedBox(height: 32),
      ReceiptDocumentSummarySection(receipt: receipt),
      const SizedBox(height: 24),
      ReceiptDocumentSignatureSection(receipt: receipt),
    ];
  }

  List<List<ReceiptItemModel>> _splitItems() {
    final items = receipt.items;

    if (items.isEmpty) {
      return const [[]];
    }

    if (items.length <= _firstPageItemCount) {
      return [items];
    }

    final chunks = <List<ReceiptItemModel>>[];
    var start = 0;
    chunks.add(items.sublist(start, start + _firstPageItemCount));
    start += _firstPageItemCount;

    while (items.length - start > _lastPageItemCount) {
      final end = math.min(
        start + _middlePageItemCount,
        items.length - _lastPageItemCount,
      );
      if (end <= start) {
        break;
      }
      chunks.add(items.sublist(start, end));
      start = end;
    }

    chunks.add(items.sublist(start));
    return chunks;
  }
}

class _ReceiptDocumentPage extends StatelessWidget {
  final Widget child;

  const _ReceiptDocumentPage({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ReceiptDocumentPaper._pageWidth,
      constraints: const BoxConstraints(
        minHeight: ReceiptDocumentPaper._pageMinHeight,
      ),
      padding: ReceiptDocumentPaper._pagePadding,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [BoxShadow(blurRadius: 20, color: Colors.black12)],
      ),
      child: child,
    );
  }
}
