import 'package:flutter/material.dart';

class ReceiptItemControllers {
  final nameController = TextEditingController();
  final codeController = TextEditingController();
  final unitController = TextEditingController();
  final quantityDocumentController = TextEditingController();
  final quantityReceivedController = TextEditingController();
  final unitPriceController = TextEditingController();

  final nameFocusNode = FocusNode();
  final codeFocusNode = FocusNode();
  final unitFocusNode = FocusNode();
  final quantityDocumentFocusNode = FocusNode();
  final quantityReceivedFocusNode = FocusNode();
  final unitPriceFocusNode = FocusNode();

  bool get hasAnyInput {
    return nameController.text.trim().isNotEmpty ||
        codeController.text.trim().isNotEmpty ||
        unitController.text.trim().isNotEmpty ||
        quantityDocumentController.text.trim().isNotEmpty ||
        quantityReceivedController.text.trim().isNotEmpty ||
        unitPriceController.text.trim().isNotEmpty;
  }

  double get totalPrice {
    final quantity =
        double.tryParse(quantityReceivedController.text.replaceAll(',', '')) ??
        0;
    final unitPrice =
        double.tryParse(unitPriceController.text.replaceAll(',', '')) ?? 0;

    return quantity * unitPrice;
  }

  void dispose() {
    nameController.dispose();
    codeController.dispose();
    unitController.dispose();
    quantityDocumentController.dispose();
    quantityReceivedController.dispose();
    unitPriceController.dispose();
    nameFocusNode.dispose();
    codeFocusNode.dispose();
    unitFocusNode.dispose();
    quantityDocumentFocusNode.dispose();
    quantityReceivedFocusNode.dispose();
    unitPriceFocusNode.dispose();
  }
}
