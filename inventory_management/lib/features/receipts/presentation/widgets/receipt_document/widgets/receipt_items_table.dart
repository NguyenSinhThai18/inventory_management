import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management/features/receipts/domain/models/receipt_detail_model.dart';

class ReceiptItemsTable extends StatelessWidget {
  static const double _tableWidth = 836;
  static const double _orderWidth = 36;
  static const double _nameWidth = 280;
  static const double _codeWidth = 60;
  static const double _unitWidth = 60;
  static const double _quantityWidth = 160;
  static const double _quantityColumnWidth = _quantityWidth / 2;
  static const double _priceWidth = 120;
  static const double _totalWidth = 118;

  final ReceiptDetailModel receipt;
  final List<ReceiptItemModel>? items;
  final bool showTotal;

  const ReceiptItemsTable({
    super.key,
    required this.receipt,
    this.items,
    this.showTotal = true,
  });

  @override
  Widget build(BuildContext context) {
    final tableItems = items ?? receipt.items;

    final total = receipt.items.fold<double>(0, (sum, e) => sum + e.totalPrice);

    return Container(
      width: _tableWidth,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Column(
        children: [
          // ================= HEADER =================
          SizedBox(
            height: 120,
            child: Row(
              children: [
                _headerCell(width: _orderWidth, text: 'S\n\nT\n\nT'),

                _headerCell(
                  width: _nameWidth,
                  text:
                      'Tên, nhãn hiệu,\n quy cách,\nphẩm chất vật tư,\ndụng cụ sản phẩm,\n hàng hoá',
                ),

                _headerCell(width: _codeWidth, text: 'Mã\nsố'),

                _headerCell(width: _unitWidth, text: 'Đơn vị\ntính'),

                _quantityHeaderCell(),

                _headerCell(width: _priceWidth, text: 'Đơn\ngiá'),

                _headerCell(
                  width: _totalWidth,
                  text: 'Thành\ntiền',
                  removeRightBorder: true,
                ),
              ],
            ),
          ),

          // ================= DATA =================
          ...tableItems.map((item) {
            return SizedBox(
              height: 58,
              child: Row(
                children: [
                  _bodyCell(
                    width: _orderWidth,
                    text: item.orderIndex.toString(),
                    center: true,
                  ),

                  _bodyCell(width: _nameWidth, text: item.productName),

                  _bodyCell(
                    width: _codeWidth,
                    text: item.productSku,
                    center: true,
                  ),

                  _bodyCell(width: _unitWidth, text: item.unit, center: true),

                  _bodyCell(
                    width: _quantityColumnWidth,
                    text: item.quantityDocument.toString(),
                    center: true,
                  ),

                  _bodyCell(
                    width: _quantityColumnWidth,
                    text: item.quantityReceived.toString(),
                    center: true,
                  ),

                  _bodyCell(
                    width: _priceWidth,
                    text: NumberFormat('#,###').format(item.unitPrice),
                    alignRight: true,
                  ),

                  _bodyCell(
                    width: _totalWidth,
                    text: NumberFormat('#,###').format(item.totalPrice),
                    alignRight: true,
                    removeRightBorder: true,
                  ),
                ],
              ),
            );
          }),

          if (showTotal)
            SizedBox(
              height: 52,
              child: Row(
                children: [
                  _bodyCell(width: _orderWidth, text: ''),

                  _bodyCell(width: _nameWidth, text: 'Cộng', bold: true),

                  _bodyCell(width: _codeWidth, text: ''),
                  _bodyCell(width: _unitWidth, text: ''),
                  _bodyCell(width: _quantityColumnWidth, text: ''),
                  _bodyCell(width: _quantityColumnWidth, text: ''),
                  _bodyCell(width: _priceWidth, text: ''),

                  _bodyCell(
                    width: _totalWidth,
                    text: NumberFormat('#,###').format(total),
                    bold: true,
                    alignRight: true,
                    removeRightBorder: true,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _quantityHeaderCell() {
    return Container(
      width: _quantityWidth,
      height: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.black),
          bottom: BorderSide(color: Colors.black),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black)),
            ),
            child: const Text(
              'Số lượng',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      border: Border(right: BorderSide(color: Colors.black)),
                    ),
                    child: const Text(
                      'Theo\nchứng\ntừ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        height: 1.3,
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Thực\nnhập',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        height: 1.3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerCell({
    required double width,
    required String text,
    bool removeRightBorder = false,
  }) {
    return Container(
      width: width,
      height: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border(
          right: removeRightBorder
              ? BorderSide.none
              : const BorderSide(color: Colors.black),
          bottom: const BorderSide(color: Colors.black),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          height: 1.35,
        ),
      ),
    );
  }

  Widget _bodyCell({
    required double width,
    required String text,
    bool bold = false,
    bool center = false,
    bool alignRight = false,
    bool removeRightBorder = false,
  }) {
    return Container(
      width: width,
      height: double.infinity,
      alignment: center
          ? Alignment.center
          : alignRight
          ? Alignment.centerRight
          : Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border(
          right: removeRightBorder
              ? BorderSide.none
              : const BorderSide(color: Colors.black),
          bottom: const BorderSide(color: Colors.black),
        ),
      ),
      child: Text(
        text,
        textAlign: center
            ? TextAlign.center
            : alignRight
            ? TextAlign.right
            : TextAlign.left,
        style: TextStyle(
          fontSize: 14,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
