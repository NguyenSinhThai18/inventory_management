import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_management/features/receipts/data/datasources/receipt_supabase_datasource.dart';
import 'package:inventory_management/features/receipts/data/helpers/receipt_create_helpers.dart';

void main() {
  group('receiptDateOnly', () {
    // Test case: định dạng ngày đầy đủ 2 chữ số cho tháng và ngày.
    test('formats date as yyyy-MM-dd with zero padding', () {
      final result = receiptDateOnly(DateTime(2026, 5, 7));

      expect(result, '2026-05-07');
    });
  });

  group('buildReceiptSignatureNote', () {
    // Test case: không có tên chữ ký nào thì note trả về null.
    test('returns null when no signature names are provided', () {
      final input = _sampleInput();

      expect(buildReceiptSignatureNote(input), isNull);
    });

    // Test case: có đủ 3 vai trò ký thì JSON chứa đủ key signatures.
    test('encodes all signature roles when provided', () {
      final input = _sampleInput(
        createdByName: 'Nguyễn Văn A',
        warehouseKeeperName: 'Trần Thị B',
        chiefAccountantName: 'Lê Văn C',
      );

      final note = buildReceiptSignatureNote(input)!;
      final decoded = jsonDecode(note) as Map<String, dynamic>;
      final signatures = decoded['signatures'] as Map<String, dynamic>;

      expect(signatures['created_by_name'], 'Nguyễn Văn A');
      expect(signatures['warehouse_keeper_name'], 'Trần Thị B');
      expect(signatures['chief_accountant_name'], 'Lê Văn C');
    });

    // Test case: chỉ có một vai trò thì JSON chỉ chứa key tương ứng.
    test('encodes only provided signature roles', () {
      final input = _sampleInput(warehouseKeeperName: 'Trần Thị B');

      final note = buildReceiptSignatureNote(input)!;
      final decoded = jsonDecode(note) as Map<String, dynamic>;
      final signatures = decoded['signatures'] as Map<String, dynamic>;

      expect(signatures.length, 1);
      expect(signatures['warehouse_keeper_name'], 'Trần Thị B');
    });
  });

  group('buildReceiptEntityCode', () {
    // Test case: chuẩn hóa tên kho thành mã WH_<TEN_IN_HOA>.
    test('normalizes warehouse name into uppercase code', () {
      final code = buildReceiptEntityCode('WH', 'Kho Trung Tâm');

      expect(code, 'WH_KHO_TRUNG_TAM');
    });

    // Test case: tên rỗng vẫn sinh mã với prefix (dùng timestamp).
    test('uses timestamp suffix when value is empty', () {
      final code = buildReceiptEntityCode('SP', '');

      expect(code.startsWith('SP_'), isTrue);
      expect(code.length, greaterThan(3));
    });
  });

  group('buildReceiptInsertPayload', () {
    // Test case: map đầy đủ field header phiếu khi có reference và chữ ký.
    test('maps receipt header fields and optional dates', () {
      final input = _sampleInput(
        referenceDate: DateTime(2026, 4, 1),
        signedAt: DateTime(2026, 5, 8),
        createdByName: 'Nguyễn Văn A',
        items: [_sampleItem()],
      );

      final payload = buildReceiptInsertPayload(
        input: input,
        warehouseId: 'wh-1',
      );

      expect(payload['receipt_number'], 'PN-001');
      expect(payload['receipt_date'], '2026-05-07');
      expect(payload['warehouse_id'], 'wh-1');
      expect(payload['reference_date'], '2026-04-01');
      expect(payload['signed_at'], '2026-05-08');
      expect(payload['note'], isNotNull);
    });

    // Test case: ngày tham chiếu và ngày ký null khi không nhập.
    test('leaves optional dates null when not provided', () {
      final input = _sampleInput(items: [_sampleItem()]);

      final payload = buildReceiptInsertPayload(
        input: input,
        warehouseId: 'wh-1',
      );

      expect(payload['reference_date'], isNull);
      expect(payload['signed_at'], isNull);
      expect(payload['note'], isNull);
    });
  });

  group('buildReceiptItemInsertPayload', () {
    // Test case: map đúng các cột dòng hàng trong phiếu.
    test('maps line item fields for inventory_receipt_items', () {
      final item = _sampleItem(
        orderIndex: 2,
        quantityDocument: 10,
        quantityReceived: 8,
        unitPrice: 50000,
        totalPrice: 400000,
      );

      final payload = buildReceiptItemInsertPayload(
        receiptId: 'rc-1',
        productId: 'prod-1',
        item: item,
      );

      expect(payload['receipt_id'], 'rc-1');
      expect(payload['product_id'], 'prod-1');
      expect(payload['order_index'], 2);
      expect(payload['quantity_document'], 10);
      expect(payload['quantity_received'], 8);
      expect(payload['unit_price'], 50000);
      expect(payload['total_price'], 400000);
    });
  });
}

CreateReceiptInput _sampleInput({
  DateTime? receiptDate,
  DateTime? referenceDate,
  DateTime? signedAt,
  String? createdByName,
  String? warehouseKeeperName,
  String? chiefAccountantName,
  List<CreateReceiptItemInput>? items,
}) {
  return CreateReceiptInput(
    receiptNumber: 'PN-001',
    receiptDate: receiptDate ?? DateTime(2026, 5, 7),
    debitAccount: '156',
    creditAccount: '331',
    deliveredBy: 'Công ty ABC',
    referenceType: 'Hóa đơn',
    referenceNumber: 'HD-99',
    referenceDate: referenceDate,
    supplierName: 'NCC XYZ',
    warehouseName: 'Kho chính',
    location: 'Hà Nội',
    companyName: 'Công ty TNHH',
    departmentName: 'Kế toán',
    totalAmount: 400000,
    attachedDocumentsCount: 2,
    signedAt: signedAt,
    createdByName: createdByName,
    warehouseKeeperName: warehouseKeeperName,
    chiefAccountantName: chiefAccountantName,
    items: items ?? const [],
  );
}

CreateReceiptItemInput _sampleItem({
  int orderIndex = 1,
  double quantityDocument = 10,
  double quantityReceived = 8,
  double unitPrice = 50000,
  double totalPrice = 400000,
}) {
  return CreateReceiptItemInput(
    orderIndex: orderIndex,
    productName: 'Sản phẩm A',
    productSku: 'SP-001',
    unit: 'Cái',
    quantityDocument: quantityDocument,
    quantityReceived: quantityReceived,
    unitPrice: unitPrice,
    totalPrice: totalPrice,
  );
}
