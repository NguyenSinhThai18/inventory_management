import 'package:intl/intl.dart';

import '../datasources/receipt_supabase_datasource.dart';

/// Kết quả map form tạo phiếu — thành công hoặc lỗi validation.
sealed class ReceiptCreateFormResult {}

class ReceiptCreateFormSuccess extends ReceiptCreateFormResult {
  final CreateReceiptInput input;

  ReceiptCreateFormSuccess(this.input);
}

class ReceiptCreateFormValidationError extends ReceiptCreateFormResult {
  final String message;

  ReceiptCreateFormValidationError(this.message);
}

/// Dữ liệu thô từ form trước khi map sang [CreateReceiptInput].
class ReceiptCreateFormData {
  final String receiptNumber;
  final String receiptDateText;
  final String? debitAccount;
  final String? creditAccount;
  final String deliveredBy;
  final String? referenceType;
  final String? referenceNumber;
  final String? referenceDateText;
  final String? supplierName;
  final String warehouseName;
  final String location;
  final String companyName;
  final String departmentName;
  final double totalAmount;
  final int attachedDocumentsCount;
  final String? signedDateText;
  final String? createdByName;
  final String? warehouseKeeperName;
  final String? chiefAccountantName;
  final List<ReceiptCreateFormItemData> items;

  const ReceiptCreateFormData({
    required this.receiptNumber,
    required this.receiptDateText,
    required this.debitAccount,
    required this.creditAccount,
    required this.deliveredBy,
    required this.referenceType,
    required this.referenceNumber,
    required this.referenceDateText,
    required this.supplierName,
    required this.warehouseName,
    required this.location,
    required this.companyName,
    required this.departmentName,
    required this.totalAmount,
    required this.attachedDocumentsCount,
    required this.signedDateText,
    required this.createdByName,
    required this.warehouseKeeperName,
    required this.chiefAccountantName,
    required this.items,
  });
}

class ReceiptCreateFormItemData {
  final int orderIndex;
  final String productName;
  final String productSku;
  final String unit;
  final double quantityDocument;
  final double quantityReceived;
  final double unitPrice;
  final double totalPrice;

  const ReceiptCreateFormItemData({
    required this.orderIndex,
    required this.productName,
    required this.productSku,
    required this.unit,
    required this.quantityDocument,
    required this.quantityReceived,
    required this.unitPrice,
    required this.totalPrice,
  });
}

class ReceiptCreateFormMapper {
  static const validationMessage =
      'Vui lòng nhập số phiếu, ngày lập, người giao, kho, địa điểm và ít nhất một dòng hàng.';

  static ReceiptCreateFormResult map(ReceiptCreateFormData data) {
    final receiptNumber = data.receiptNumber.trim();
    final deliveredBy = data.deliveredBy.trim();
    final warehouseName = data.warehouseName.trim();
    final location = data.location.trim();
    final receiptDate = parseReceiptDate(data.receiptDateText);
    final referenceDate = parseOptionalReceiptDate(data.referenceDateText);
    final signedAt = parseOptionalReceiptDate(data.signedDateText);

    final validItems = data.items
        .where((item) => item.productName.trim().isNotEmpty)
        .map(
          (item) => CreateReceiptItemInput(
            orderIndex: item.orderIndex,
            productName: item.productName.trim(),
            productSku: item.productSku.trim(),
            unit: item.unit.trim(),
            quantityDocument: item.quantityDocument,
            quantityReceived: item.quantityReceived,
            unitPrice: item.unitPrice,
            totalPrice: item.totalPrice,
          ),
        )
        .toList();

    if (receiptNumber.isEmpty ||
        deliveredBy.isEmpty ||
        warehouseName.isEmpty ||
        location.isEmpty ||
        receiptDate == null ||
        validItems.isEmpty) {
      return ReceiptCreateFormValidationError(validationMessage);
    }

    return ReceiptCreateFormSuccess(
      CreateReceiptInput(
        receiptNumber: receiptNumber,
        receiptDate: receiptDate,
        debitAccount: data.debitAccount,
        creditAccount: data.creditAccount,
        deliveredBy: deliveredBy,
        referenceType: data.referenceType,
        referenceNumber: data.referenceNumber,
        referenceDate: referenceDate,
        supplierName: data.supplierName,
        warehouseName: warehouseName,
        location: location,
        companyName: data.companyName.trim(),
        departmentName: data.departmentName.trim(),
        totalAmount: data.totalAmount,
        attachedDocumentsCount: data.attachedDocumentsCount,
        signedAt: signedAt,
        createdByName: data.createdByName,
        warehouseKeeperName: data.warehouseKeeperName,
        chiefAccountantName: data.chiefAccountantName,
        items: validItems,
      ),
    );
  }

  static DateTime? parseReceiptDate(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return null;
    }

    try {
      return DateFormat('dd/MM/yyyy').parseStrict(trimmed);
    } catch (_) {
      return null;
    }
  }

  static DateTime? parseOptionalReceiptDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    return parseReceiptDate(value);
  }

  static double parseReceiptNumber(String value) {
    final normalized = value.replaceAll(',', '').trim();
    return double.tryParse(normalized) ?? 0;
  }
}
