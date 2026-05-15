class ReceiptListItemModel {
  final String id;
  final String receiptNumber;
  final DateTime receiptDate;
  final String warehouseName;
  final String deliveredBy;
  final double totalAmount;

  const ReceiptListItemModel({
    required this.id,
    required this.receiptNumber,
    required this.receiptDate,
    required this.warehouseName,
    required this.deliveredBy,
    required this.totalAmount,
  });

  factory ReceiptListItemModel.fromJson(Map<String, dynamic> json) {
    return ReceiptListItemModel(
      id: json['id'],

      receiptNumber: json['receipt_number'] ?? '',

      receiptDate: DateTime.parse(json['receipt_date']),

      warehouseName: json['warehouse']?['name'] ?? '',

      deliveredBy: json['delivered_by'] ?? '',

      totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0,
    );
  }
}
