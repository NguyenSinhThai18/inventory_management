import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management/features/receipts/data/datasources/receipt_supabase_datasource.dart';
import 'package:inventory_management/features/receipts/data/mappers/receipt_create_form_mapper.dart';
import 'package:inventory_management/features/receipts/presentation/providers/receipt_provider.dart';
import 'package:inventory_management/features/receipts/presentation/widgets/receipt_document/dialogs/create_receipt_form/receipt_account_form_section.dart';
import 'package:inventory_management/features/receipts/presentation/widgets/receipt_document/dialogs/create_receipt_form/receipt_item_controllers.dart';
import 'package:inventory_management/features/receipts/presentation/widgets/receipt_document/dialogs/create_receipt_form/receipt_items_form_table.dart';
import 'package:inventory_management/features/receipts/presentation/widgets/receipt_document/dialogs/create_receipt_form/receipt_reference_form_section.dart';
import 'package:inventory_management/features/receipts/presentation/widgets/receipt_document/dialogs/create_receipt_form/receipt_signature_form_section.dart';
import 'package:inventory_management/features/receipts/presentation/widgets/receipt_document/dialogs/create_receipt_form/receipt_summary_form_section.dart';
import 'package:inventory_management/features/receipts/presentation/widgets/receipt_document/dialogs/create_receipt_form/receipt_title_form_section.dart';
import 'package:inventory_management/features/receipts/presentation/widgets/receipt_document/dialogs/create_receipt_form/receipt_top_form_section.dart';
import 'package:inventory_management/features/receipts/presentation/widgets/receipt_document/widgets/receipt_document_header.dart';

class ReceiptCreateDialog extends ConsumerStatefulWidget {
  const ReceiptCreateDialog({super.key});

  @override
  ConsumerState<ReceiptCreateDialog> createState() =>
      _ReceiptCreateDialogState();
}

class _ReceiptCreateDialogState extends ConsumerState<ReceiptCreateDialog> {
  static const double _pageWidth = 936;
  static const EdgeInsets _pagePadding = EdgeInsets.fromLTRB(32, 60, 32, 60);

  final _companyController = TextEditingController();
  final _departmentController = TextEditingController();
  final _receiptNumberController = TextEditingController();
  final _receiptDateController = TextEditingController();
  final _debitAccountController = TextEditingController();
  final _creditAccountController = TextEditingController();
  final _deliveredByController = TextEditingController();
  final _referenceTypeController = TextEditingController();
  final _referenceNumberController = TextEditingController();
  final _referenceDateController = TextEditingController();
  final _supplierController = TextEditingController();
  final _warehouseController = TextEditingController();
  final _locationController = TextEditingController();
  final _attachedDocumentsController = TextEditingController();
  final _attachedDocumentsFocusNode = FocusNode();
  final _signedDateController = TextEditingController();
  final _createdByController = TextEditingController();
  final _warehouseKeeperController = TextEditingController();
  final _chiefAccountantController = TextEditingController();
  final List<ReceiptItemControllers> _items = [ReceiptItemControllers()];
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _receiptDateController.text = DateFormat(
      'dd/MM/yyyy',
    ).format(DateTime.now());
    _signedDateController.text = DateFormat(
      'dd/MM/yyyy',
    ).format(DateTime.now());
  }

  @override
  void dispose() {
    _companyController.dispose();
    _departmentController.dispose();
    _receiptNumberController.dispose();
    _receiptDateController.dispose();
    _debitAccountController.dispose();
    _creditAccountController.dispose();
    _deliveredByController.dispose();
    _referenceTypeController.dispose();
    _referenceNumberController.dispose();
    _referenceDateController.dispose();
    _supplierController.dispose();
    _warehouseController.dispose();
    _locationController.dispose();
    _attachedDocumentsController.dispose();
    _attachedDocumentsFocusNode.dispose();
    _signedDateController.dispose();
    _createdByController.dispose();
    _warehouseKeeperController.dispose();
    _chiefAccountantController.dispose();
    for (final item in _items) {
      item.dispose();
    }
    super.dispose();
  }

  double get _totalAmount {
    return _items.fold<double>(0, (sum, item) => sum + item.totalPrice);
  }

  void _addItem() {
    setState(() {
      _items.add(ReceiptItemControllers());
    });
  }

  void _removeItem(int index) {
    if (_items.length == 1) {
      return;
    }

    setState(() {
      _items.removeAt(index).dispose();
    });
  }

  Future<void> _save({required bool printAfterSave}) async {
    if (_isSaving) {
      return;
    }

    final input = _buildInput();
    if (input == null) {
      return;
    }

    setState(() => _isSaving = true);

    try {
      await ref.read(receiptDatasourceProvider).createReceipt(input);
      ref.invalidate(receiptsProvider);

      if (!mounted) {
        return;
      }

      final messenger = ScaffoldMessenger.of(context);
      Navigator.pop(context);
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            printAfterSave ? 'Đã lưu phiếu và chuẩn bị in' : 'Đã lưu phiếu',
          ),
        ),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Không thể lưu phiếu: $error')));
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  CreateReceiptInput? _buildInput() {
    final formData = ReceiptCreateFormData(
      receiptNumber: _receiptNumberController.text,
      receiptDateText: _receiptDateController.text,
      debitAccount: _trimmedOrNull(_debitAccountController),
      creditAccount: _trimmedOrNull(_creditAccountController),
      deliveredBy: _deliveredByController.text,
      referenceType: _trimmedOrNull(_referenceTypeController),
      referenceNumber: _trimmedOrNull(_referenceNumberController),
      referenceDateText: _referenceDateController.text,
      supplierName: _trimmedOrNull(_supplierController),
      warehouseName: _warehouseController.text,
      location: _locationController.text,
      companyName: _companyController.text,
      departmentName: _departmentController.text,
      totalAmount: _totalAmount,
      attachedDocumentsCount:
          int.tryParse(_attachedDocumentsController.text.trim()) ?? 0,
      signedDateText: _signedDateController.text,
      createdByName: _trimmedOrNull(_createdByController),
      warehouseKeeperName: _trimmedOrNull(_warehouseKeeperController),
      chiefAccountantName: _trimmedOrNull(_chiefAccountantController),
      items: [
        for (var i = 0; i < _items.length; i++)
          ReceiptCreateFormItemData(
            orderIndex: i + 1,
            productName: _items[i].nameController.text,
            productSku: _items[i].codeController.text,
            unit: _items[i].unitController.text,
            quantityDocument: ReceiptCreateFormMapper.parseReceiptNumber(
              _items[i].quantityDocumentController.text,
            ),
            quantityReceived: ReceiptCreateFormMapper.parseReceiptNumber(
              _items[i].quantityReceivedController.text,
            ),
            unitPrice: ReceiptCreateFormMapper.parseReceiptNumber(
              _items[i].unitPriceController.text,
            ),
            totalPrice: _items[i].totalPrice,
          ),
      ],
    );

    final result = ReceiptCreateFormMapper.map(formData);
    switch (result) {
      case ReceiptCreateFormSuccess(:final input):
        return input;
      case ReceiptCreateFormValidationError(:final message):
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
        return null;
    }
  }

  String? _trimmedOrNull(TextEditingController controller) {
    final value = controller.text.trim();
    return value.isEmpty ? null : value;
  }

  @override
  Widget build(BuildContext context) {
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
            ReceiptDocumentHeader(
              title: _isSaving ? 'Saving Receipt...' : 'Create Receipt',
              primaryActionLabel: _isSaving ? 'Saving...' : 'Save & Print',
              primaryActionIcon: Icons.print,
              onPrimaryAction: _isSaving
                  ? null
                  : () => _save(printAfterSave: true),
              secondaryActionLabel: _isSaving ? null : 'Save',
              onSecondaryAction: _isSaving
                  ? null
                  : () => _save(printAfterSave: false),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(28),
                child: Center(
                  child: Container(
                    width: _pageWidth,
                    padding: _pagePadding,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(blurRadius: 20, color: Colors.black12),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReceiptTopFormSection(
                          companyController: _companyController,
                          departmentController: _departmentController,
                        ),
                        const SizedBox(height: 30),
                        ReceiptTitleFormSection(
                          dateController: _receiptDateController,
                        ),
                        const SizedBox(height: 12),
                        ReceiptAccountFormSection(
                          receiptNumberController: _receiptNumberController,
                          debitAccountController: _debitAccountController,
                          creditAccountController: _creditAccountController,
                        ),
                        const SizedBox(height: 12),
                        ReceiptReferenceFormSection(
                          deliveredByController: _deliveredByController,
                          referenceTypeController: _referenceTypeController,
                          referenceNumberController: _referenceNumberController,
                          referenceDateController: _referenceDateController,
                          supplierController: _supplierController,
                          warehouseController: _warehouseController,
                          locationController: _locationController,
                        ),
                        const SizedBox(height: 30),
                        ReceiptItemsFormTable(
                          items: _items,
                          onChanged: () => setState(() {}),
                          onAddItem: _addItem,
                          onRemoveItem: _removeItem,
                          nextFocusNode: _attachedDocumentsFocusNode,
                        ),
                        const SizedBox(height: 32),
                        ReceiptSummaryFormSection(
                          totalAmount: _totalAmount,
                          attachedDocumentsController:
                              _attachedDocumentsController,
                          attachedDocumentsFocusNode:
                              _attachedDocumentsFocusNode,
                          signedDateController: _signedDateController,
                        ),
                        const SizedBox(height: 24),
                        ReceiptSignatureFormSection(
                          createdByController: _createdByController,
                          deliveredByController: _deliveredByController,
                          warehouseKeeperController: _warehouseKeeperController,
                          chiefAccountantController: _chiefAccountantController,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
