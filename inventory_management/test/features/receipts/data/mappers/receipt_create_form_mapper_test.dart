import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_management/features/receipts/data/mappers/receipt_create_form_mapper.dart';

void main() {
  group('ReceiptCreateFormMapper.map', () {
    // Test case: form hợp lệ trả về CreateReceiptInput đầy đủ.
    test('returns success when required fields and one item are valid', () {
      final result = ReceiptCreateFormMapper.map(_validFormData());

      expect(result, isA<ReceiptCreateFormSuccess>());
      final input = (result as ReceiptCreateFormSuccess).input;
      expect(input.receiptNumber, 'PN-001');
      expect(input.deliveredBy, 'Nguyễn Văn Giao');
      expect(input.warehouseName, 'Kho A');
      expect(input.location, 'Hà Nội');
      expect(input.items.length, 1);
      expect(input.items.first.productName, 'Laptop');
    });

    // Test case: thiếu số phiếu thì validation error.
    test('returns validation error when receipt number is empty', () {
      final result = ReceiptCreateFormMapper.map(
        _validFormData(receiptNumber: '  '),
      );

      expect(result, isA<ReceiptCreateFormValidationError>());
    });

    // Test case: thiếu người giao hàng.
    test('returns validation error when delivered by is empty', () {
      final result = ReceiptCreateFormMapper.map(
        _validFormData(deliveredBy: ''),
      );

      expect(result, isA<ReceiptCreateFormValidationError>());
    });

    // Test case: thiếu tên kho.
    test('returns validation error when warehouse name is empty', () {
      final result = ReceiptCreateFormMapper.map(
        _validFormData(warehouseName: ''),
      );

      expect(result, isA<ReceiptCreateFormValidationError>());
    });

    // Test case: thiếu địa điểm.
    test('returns validation error when location is empty', () {
      final result = ReceiptCreateFormMapper.map(
        _validFormData(location: ''),
      );

      expect(result, isA<ReceiptCreateFormValidationError>());
    });

    // Test case: ngày lập sai định dạng.
    test('returns validation error when receipt date is invalid', () {
      final result = ReceiptCreateFormMapper.map(
        _validFormData(receiptDateText: '32/13/2026'),
      );

      expect(result, isA<ReceiptCreateFormValidationError>());
    });

    // Test case: không có dòng hàng hợp lệ (tên sản phẩm rỗng).
    test('returns validation error when no valid line items exist', () {
      final result = ReceiptCreateFormMapper.map(
        _validFormData(
          items: const [
            ReceiptCreateFormItemData(
              orderIndex: 1,
              productName: '   ',
              productSku: '',
              unit: '',
              quantityDocument: 0,
              quantityReceived: 0,
              unitPrice: 0,
              totalPrice: 0,
            ),
          ],
        ),
      );

      expect(result, isA<ReceiptCreateFormValidationError>());
    });

    // Test case: bỏ qua dòng hàng trống, chỉ giữ dòng có tên sản phẩm.
    test('skips empty line items and keeps rows with product name', () {
      final result = ReceiptCreateFormMapper.map(
        _validFormData(
          items: const [
            ReceiptCreateFormItemData(
              orderIndex: 1,
              productName: '',
              productSku: '',
              unit: '',
              quantityDocument: 0,
              quantityReceived: 0,
              unitPrice: 0,
              totalPrice: 0,
            ),
            ReceiptCreateFormItemData(
              orderIndex: 2,
              productName: 'Chuột',
              productSku: 'MS-01',
              unit: 'Cái',
              quantityDocument: 5,
              quantityReceived: 5,
              unitPrice: 100000,
              totalPrice: 500000,
            ),
          ],
        ),
      );

      expect(result, isA<ReceiptCreateFormSuccess>());
      final input = (result as ReceiptCreateFormSuccess).input;
      expect(input.items.length, 1);
      expect(input.items.first.productName, 'Chuột');
      expect(input.items.first.orderIndex, 2);
    });

    // Test case: ngày tham chiếu và ngày ký để trống thì null.
    test('parses optional reference and signed dates as null when empty', () {
      final result = ReceiptCreateFormMapper.map(
        _validFormData(referenceDateText: '', signedDateText: ''),
      );

      final input = (result as ReceiptCreateFormSuccess).input;
      expect(input.referenceDate, isNull);
      expect(input.signedAt, isNull);
    });
  });

  group('ReceiptCreateFormMapper.parseReceiptNumber', () {
    // Test case: chuỗi số có dấu phẩy ngăn cách hàng nghìn.
    test('parses numbers with comma separators', () {
      expect(
        ReceiptCreateFormMapper.parseReceiptNumber('1,250,000'),
        1250000,
      );
    });

    // Test case: chuỗi không hợp lệ trả về 0.
    test('returns zero for invalid numeric text', () {
      expect(ReceiptCreateFormMapper.parseReceiptNumber('abc'), 0);
    });
  });

  group('ReceiptCreateFormMapper.parseReceiptDate', () {
    // Test case: parse đúng định dạng dd/MM/yyyy.
    test('parses strict dd/MM/yyyy format', () {
      final date = ReceiptCreateFormMapper.parseReceiptDate('15/05/2026');

      expect(date, DateTime(2026, 5, 15));
    });

    // Test case: chuỗi rỗng trả về null.
    test('returns null for empty date text', () {
      expect(ReceiptCreateFormMapper.parseReceiptDate(''), isNull);
    });
  });
}

ReceiptCreateFormData _validFormData({
  String receiptNumber = 'PN-001',
  String receiptDateText = '07/05/2026',
  String deliveredBy = 'Nguyễn Văn Giao',
  String warehouseName = 'Kho A',
  String location = 'Hà Nội',
  String? referenceDateText = '01/04/2026',
  String? signedDateText = '08/05/2026',
  List<ReceiptCreateFormItemData>? items,
}) {
  return ReceiptCreateFormData(
    receiptNumber: receiptNumber,
    receiptDateText: receiptDateText,
    debitAccount: '156',
    creditAccount: '331',
    deliveredBy: deliveredBy,
    referenceType: 'Hóa đơn',
    referenceNumber: 'HD-1',
    referenceDateText: referenceDateText,
    supplierName: 'NCC A',
    warehouseName: warehouseName,
    location: location,
    companyName: 'Công ty X',
    departmentName: 'Kế toán',
    totalAmount: 500000,
    attachedDocumentsCount: 1,
    signedDateText: signedDateText,
    createdByName: null,
    warehouseKeeperName: null,
    chiefAccountantName: null,
    items:
        items ??
        const [
          ReceiptCreateFormItemData(
            orderIndex: 1,
            productName: 'Laptop',
            productSku: 'LT-01',
            unit: 'Cái',
            quantityDocument: 1,
            quantityReceived: 1,
            unitPrice: 500000,
            totalPrice: 500000,
          ),
        ],
  );
}
