import 'dart:convert';

class ReceiptDetailModel {
  final String id;
  final String receiptNumber;
  final DateTime receiptDate;

  final String? debitAccount;
  final String? creditAccount;

  final String deliveredBy;

  final String? referenceNumber;
  final DateTime? referenceDate;
  final String? referenceType;
  final String? supplierName;

  final String warehouseName;
  final String location;

  final String companyName;
  final String departmentName;

  final double totalAmount;
  final int attachedDocumentsCount;

  final DateTime? signedAt;

  final String createdByName;
  final String warehouseKeeperName;
  final String chiefAccountantName;

  final List<ReceiptItemModel> items;

  const ReceiptDetailModel({
    required this.id,
    required this.receiptNumber,
    required this.receiptDate,
    required this.debitAccount,
    required this.creditAccount,
    required this.deliveredBy,
    required this.referenceNumber,
    required this.referenceDate,
    required this.referenceType,
    required this.supplierName,
    required this.warehouseName,
    required this.location,
    required this.companyName,
    required this.departmentName,
    required this.totalAmount,
    required this.attachedDocumentsCount,
    required this.signedAt,
    required this.createdByName,
    required this.warehouseKeeperName,
    required this.chiefAccountantName,
    required this.items,
  });

  factory ReceiptDetailModel.fromJson(Map<String, dynamic> json) {
    final signatureNames = _signatureNamesFromNote(json['note']);

    return ReceiptDetailModel(
      id: json['id'] ?? '',

      receiptNumber: json['receipt_number'] ?? '',

      receiptDate: DateTime.parse(json['receipt_date']),

      debitAccount: json['debit_account'],

      creditAccount: json['credit_account'],

      deliveredBy: json['delivered_by'] ?? '',

      referenceNumber: json['reference_number'],

      referenceDate: json['reference_date'] != null
          ? DateTime.parse(json['reference_date'])
          : null,

      referenceType: json['reference_type'],

      supplierName: json['supplier_name'],

      warehouseName: json['warehouse']?['name'] ?? '',

      location: json['warehouse']?['location'] ?? '',

      companyName: json['company_name'] ?? '',

      departmentName: json['department_name'] ?? '',

      totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0,

      attachedDocumentsCount: json['attached_documents_count'] ?? 0,

      signedAt: json['signed_at'] != null
          ? DateTime.parse(json['signed_at'])
          : null,

      createdByName:
          _nameFromJson(json['created_by']) ??
          (json['created_by_name'] as String?) ??
          signatureNames['created_by_name'] ??
          '',

      warehouseKeeperName:
          _nameFromJson(json['warehouse_keeper']) ??
          (json['warehouse_keeper_name'] as String?) ??
          signatureNames['warehouse_keeper_name'] ??
          '',

      chiefAccountantName:
          _nameFromJson(json['chief_accountant']) ??
          (json['chief_accountant_name'] as String?) ??
          signatureNames['chief_accountant_name'] ??
          '',

      items:
          (json['items'] as List?)
              ?.map((e) => ReceiptItemModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  static String? _nameFromJson(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value['full_name'] as String?;
    }

    if (value is String && value.trim().isNotEmpty) {
      return value;
    }

    return null;
  }

  static Map<String, String> _signatureNamesFromNote(dynamic value) {
    if (value is! String || value.trim().isEmpty) {
      return const {};
    }

    try {
      final decoded = jsonDecode(value);
      if (decoded is! Map<String, dynamic>) {
        return const {};
      }

      final signatures = decoded['signatures'];
      if (signatures is! Map<String, dynamic>) {
        return const {};
      }

      return signatures.map(
        (key, value) => MapEntry(key, value?.toString() ?? ''),
      );
    } catch (_) {
      return const {};
    }
  }
}

class ReceiptItemModel {
  final int orderIndex;

  final String productName;
  final String productSku;
  final String unit;

  final double quantityDocument;
  final double quantityReceived;

  final double unitPrice;
  final double totalPrice;

  const ReceiptItemModel({
    required this.orderIndex,
    required this.productName,
    required this.productSku,
    required this.unit,
    required this.quantityDocument,
    required this.quantityReceived,
    required this.unitPrice,
    required this.totalPrice,
  });

  factory ReceiptItemModel.fromJson(Map<String, dynamic> json) {
    return ReceiptItemModel(
      orderIndex: json['order_index'] ?? 0,

      productName: json['product']?['name'] ?? '',

      productSku: json['product']?['sku'] ?? '',

      unit: json['product']?['unit'] ?? '',

      quantityDocument: (json['quantity_document'] as num?)?.toDouble() ?? 0,

      quantityReceived: (json['quantity_received'] as num?)?.toDouble() ?? 0,

      unitPrice: (json['unit_price'] as num?)?.toDouble() ?? 0,

      totalPrice: (json['total_price'] as num?)?.toDouble() ?? 0,
    );
  }
}
