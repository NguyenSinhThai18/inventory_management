import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_management/features/receipts/data/datasources/receipt_supabase_datasource.dart';

void main() {
  late Map<String, dynamic>? capturedReceiptPayload;
  late List<Map<String, dynamic>> capturedItemRows;
  late ReceiptSupabaseDatasource datasource;

  setUp(() {
    capturedReceiptPayload = null;
    capturedItemRows = [];
    datasource = ReceiptSupabaseDatasource(
      findOrCreateWarehouse: ({required name, required location}) async {
        return 'warehouse-fixed-id';
      },
      findOrCreateProduct: ({required sku, required name, required unit}) async {
        return 'product-$sku-$name';
      },
      persistCreatedReceipt:
          ({required receiptPayload, required itemRows}) async {
            capturedReceiptPayload = receiptPayload;
            capturedItemRows = itemRows;
            return 'receipt-test-id';
          },
    );
  });

  group('ReceiptSupabaseDatasource.createReceipt', () {
    // Test case: lưu thành công và trả về id phiếu mới.
    test('returns new receipt id after successful insert', () async {
      final receiptId = await datasource.createReceipt(_sampleInput());

      expect(receiptId, 'receipt-test-id');
    });

    // Test case: header phiếu được ghi đúng warehouse_id từ resolver.
    test('stores receipt header with resolved warehouse id', () async {
      await datasource.createReceipt(_sampleInput());

      expect(capturedReceiptPayload!['warehouse_id'], 'warehouse-fixed-id');
      expect(capturedReceiptPayload!['receipt_number'], 'PN-001');
      expect(capturedReceiptPayload!['delivered_by'], 'Nguyễn Văn Giao');
      expect(capturedReceiptPayload!['total_amount'], 500000);
    });

    // Test case: mỗi dòng hàng được chuẩn bị kèm product_id đã resolve.
    test('builds one receipt item row per input item', () async {
      await datasource.createReceipt(
        _sampleInput(
          items: [
            _sampleItem(orderIndex: 1, productSku: 'A'),
            _sampleItem(orderIndex: 2, productSku: 'B', productName: 'SP B'),
          ],
        ),
      );

      expect(capturedItemRows, hasLength(2));
      expect(capturedItemRows[0]['product_id'], 'product-A-Sản phẩm A');
      expect(capturedItemRows[1]['product_id'], 'product-B-SP B');
      expect(capturedItemRows[0]['order_index'], 1);
      expect(capturedItemRows[1]['order_index'], 2);
    });

    // Test case: danh sách items rỗng thì không tạo dòng hàng.
    test('does not build receipt items when items list is empty', () async {
      await datasource.createReceipt(_sampleInput(items: const []));

      expect(capturedItemRows, isEmpty);
      expect(capturedReceiptPayload, isNotNull);
    });

    // Test case: note chứa JSON chữ ký khi có thông tin ký.
    test('persists signature note json in receipt header', () async {
      await datasource.createReceipt(
        _sampleInput(
          createdByName: 'Người lập',
          warehouseKeeperName: 'Thủ kho',
          chiefAccountantName: 'Kế toán trưởng',
        ),
      );

      expect(capturedReceiptPayload!['note'], contains('created_by_name'));
      expect(capturedReceiptPayload!['note'], contains('Người lập'));
    });
  });
}

CreateReceiptInput _sampleInput({
  List<CreateReceiptItemInput>? items,
  String? createdByName,
  String? warehouseKeeperName,
  String? chiefAccountantName,
}) {
  return CreateReceiptInput(
    receiptNumber: 'PN-001',
    receiptDate: DateTime(2026, 5, 7),
    debitAccount: '156',
    creditAccount: '331',
    deliveredBy: 'Nguyễn Văn Giao',
    referenceType: 'Hóa đơn',
    referenceNumber: 'HD-1',
    referenceDate: DateTime(2026, 4, 1),
    supplierName: 'NCC A',
    warehouseName: 'Kho A',
    location: 'Hà Nội',
    companyName: 'Công ty X',
    departmentName: 'Kế toán',
    totalAmount: 500000,
    attachedDocumentsCount: 1,
    signedAt: DateTime(2026, 5, 8),
    createdByName: createdByName,
    warehouseKeeperName: warehouseKeeperName,
    chiefAccountantName: chiefAccountantName,
    items: items ?? [_sampleItem()],
  );
}

CreateReceiptItemInput _sampleItem({
  int orderIndex = 1,
  String productSku = 'SP-001',
  String productName = 'Sản phẩm A',
}) {
  return CreateReceiptItemInput(
    orderIndex: orderIndex,
    productName: productName,
    productSku: productSku,
    unit: 'Cái',
    quantityDocument: 10,
    quantityReceived: 8,
    unitPrice: 50000,
    totalPrice: 400000,
  );
}
