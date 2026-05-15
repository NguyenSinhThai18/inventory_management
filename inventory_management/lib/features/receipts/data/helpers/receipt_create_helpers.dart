import 'dart:convert';

import '../datasources/receipt_supabase_datasource.dart';

/// Định dạng ngày theo chuẩn cột DATE của Postgres (yyyy-MM-dd).
String receiptDateOnly(DateTime date) {
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');
  return '${date.year}-$month-$day';
}

/// Gộp thông tin chữ ký vào cột note dạng JSON.
String? buildReceiptSignatureNote(CreateReceiptInput input) {
  final signatures = <String, String>{
    if (input.createdByName != null) 'created_by_name': input.createdByName!,
    if (input.warehouseKeeperName != null)
      'warehouse_keeper_name': input.warehouseKeeperName!,
    if (input.chiefAccountantName != null)
      'chief_accountant_name': input.chiefAccountantName!,
  };

  if (signatures.isEmpty) {
    return null;
  }

  return jsonEncode({'signatures': signatures});
}

/// Sinh mã kho/sản phẩm từ tên khi chưa có SKU hoặc mã riêng.
String buildReceiptEntityCode(String prefix, String value) {
  final normalized = value
      .toUpperCase()
      .replaceAll(RegExp(r'[^A-Z0-9]+'), '_')
      .replaceAll(RegExp(r'_+'), '_')
      .replaceAll(RegExp(r'^_|_$'), '');
  final suffix = normalized.isEmpty
      ? DateTime.now().microsecondsSinceEpoch.toString()
      : normalized;

  return '${prefix}_$suffix';
}

/// Payload insert bảng inventory_receipts.
Map<String, dynamic> buildReceiptInsertPayload({
  required CreateReceiptInput input,
  required String warehouseId,
}) {
  return {
    'receipt_number': input.receiptNumber,
    'receipt_date': receiptDateOnly(input.receiptDate),
    'debit_account': input.debitAccount,
    'credit_account': input.creditAccount,
    'delivered_by': input.deliveredBy,
    'reference_type': input.referenceType,
    'reference_number': input.referenceNumber,
    'reference_date': input.referenceDate != null
        ? receiptDateOnly(input.referenceDate!)
        : null,
    'supplier_name': input.supplierName,
    'warehouse_id': warehouseId,
    'company_name': input.companyName,
    'department_name': input.departmentName,
    'location': input.location,
    'total_amount': input.totalAmount,
    'attached_documents_count': input.attachedDocumentsCount,
    'signed_at': input.signedAt != null ? receiptDateOnly(input.signedAt!) : null,
    'note': buildReceiptSignatureNote(input),
  };
}

/// Payload insert một dòng inventory_receipt_items.
Map<String, dynamic> buildReceiptItemInsertPayload({
  required String receiptId,
  required String productId,
  required CreateReceiptItemInput item,
}) {
  return {
    'receipt_id': receiptId,
    'order_index': item.orderIndex,
    'product_id': productId,
    'quantity_document': item.quantityDocument,
    'quantity_received': item.quantityReceived,
    'unit_price': item.unitPrice,
    'total_price': item.totalPrice,
  };
}
