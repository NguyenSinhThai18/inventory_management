import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management/features/receipts/presentation/widgets/receipt_document/dialogs/create_receipt_form/receipt_form_inputs.dart';
import 'package:inventory_management/features/receipts/presentation/widgets/receipt_document/dialogs/create_receipt_form/receipt_item_controllers.dart';

class ReceiptItemsFormTable extends StatelessWidget {
  static const double _tableWidth = 836;
  static const double _orderWidth = 36;
  static const double _nameWidth = 280;
  static const double _codeWidth = 60;
  static const double _unitWidth = 60;
  static const double _quantityWidth = 160;
  static const double _quantityColumnWidth = _quantityWidth / 2;
  static const double _priceWidth = 120;
  static const double _totalWidth = 118;
  static const double _actionWidth = 36;

  final List<ReceiptItemControllers> items;
  final VoidCallback onChanged;
  final VoidCallback onAddItem;
  final ValueChanged<int> onRemoveItem;
  final FocusNode? nextFocusNode;

  const ReceiptItemsFormTable({
    super.key,
    required this.items,
    required this.onChanged,
    required this.onAddItem,
    required this.onRemoveItem,
    this.nextFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    final total = items.fold<double>(0, (sum, item) => sum + item.totalPrice);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: _tableWidth + _actionWidth,
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Column(
            children: [
              SizedBox(
                height: 120,
                child: Row(
                  children: [
                    _headerCell(width: _orderWidth, text: 'S\n\nT\n\nT'),
                    _headerCell(
                      width: _nameWidth,
                      text:
                          'Tên, nhãn hiệu, quy cách,\nphẩm chất vật tư,\ndụng cụ sản phẩm, hàng hoá',
                    ),
                    _headerCell(width: _codeWidth, text: 'Mã\nsố'),
                    _headerCell(width: _unitWidth, text: 'Đơn vị\ntính'),
                    _quantityHeaderCell(),
                    _headerCell(width: _priceWidth, text: 'Đơn\ngiá'),
                    _headerCell(width: _totalWidth, text: 'Thành\ntiền'),
                    _headerCell(
                      width: _actionWidth,
                      text: '',
                      removeRightBorder: true,
                    ),
                  ],
                ),
              ),
              for (var i = 0; i < items.length; i++)
                _ReceiptItemFormRow(
                  index: i,
                  isLast: i == items.length - 1,
                  canRemoveEmptyRow: items.length > 1,
                  nextFocusNode: nextFocusNode,
                  item: items[i],
                  items: items,
                  onChanged: onChanged,
                  onAddItem: onAddItem,
                  onRemove: () => onRemoveItem(i),
                ),
              SizedBox(
                height: 52,
                child: Row(
                  children: [
                    _bodyCell(width: _orderWidth, child: const SizedBox()),
                    _bodyCell(
                      width: _nameWidth,
                      child: const Text(
                        'Cộng',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    _bodyCell(width: _codeWidth, child: const SizedBox()),
                    _bodyCell(width: _unitWidth, child: const SizedBox()),
                    _bodyCell(
                      width: _quantityColumnWidth,
                      child: const SizedBox(),
                    ),
                    _bodyCell(
                      width: _quantityColumnWidth,
                      child: const SizedBox(),
                    ),
                    _bodyCell(width: _priceWidth, child: const SizedBox()),
                    _bodyCell(
                      width: _totalWidth,
                      alignRight: true,
                      child: Text(
                        NumberFormat('#,###').format(total),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    _bodyCell(
                      width: _actionWidth,
                      removeRightBorder: true,
                      child: const SizedBox(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: onAddItem,
          icon: const Icon(Icons.add),
          label: const Text('Thêm dòng hàng'),
        ),
      ],
    );
  }

  static Widget _quantityHeaderCell() {
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
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Thực\nnhập',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
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

  static Widget _headerCell({
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
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  static Widget _bodyCell({
    required double width,
    required Widget child,
    bool alignRight = false,
    bool removeRightBorder = false,
  }) {
    return Container(
      width: width,
      height: double.infinity,
      alignment: alignRight ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        border: Border(
          right: removeRightBorder
              ? BorderSide.none
              : const BorderSide(color: Colors.black),
          bottom: const BorderSide(color: Colors.black),
        ),
      ),
      child: child,
    );
  }
}

class _ReceiptItemFormRow extends StatelessWidget {
  final int index;
  final bool isLast;
  final bool canRemoveEmptyRow;
  final FocusNode? nextFocusNode;
  final ReceiptItemControllers item;
  final List<ReceiptItemControllers> items;
  final VoidCallback onChanged;
  final VoidCallback onAddItem;
  final VoidCallback onRemove;

  const _ReceiptItemFormRow({
    required this.index,
    required this.isLast,
    required this.canRemoveEmptyRow,
    required this.nextFocusNode,
    required this.item,
    required this.items,
    required this.onChanged,
    required this.onAddItem,
    required this.onRemove,
  });

  KeyEventResult _handleLastFieldTab(BuildContext context, KeyEvent event) {
    if (!isLast ||
        event is! KeyDownEvent ||
        event.logicalKey != LogicalKeyboardKey.tab ||
        HardwareKeyboard.instance.isShiftPressed) {
      return KeyEventResult.ignored;
    }

    if (!item.hasAnyInput) {
      if (canRemoveEmptyRow) {
        onRemove();
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (nextFocusNode != null) {
          nextFocusNode!.requestFocus();
          return;
        }

        FocusScope.of(context).nextFocus();
      });
      return KeyEventResult.handled;
    }

    onAddItem();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      items.last.nameFocusNode.requestFocus();
    });
    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: Row(
        children: [
          ReceiptItemsFormTable._bodyCell(
            width: ReceiptItemsFormTable._orderWidth,
            child: Center(child: Text('${index + 1}')),
          ),
          ReceiptItemsFormTable._bodyCell(
            width: ReceiptItemsFormTable._nameWidth,
            child: TableInput(
              controller: item.nameController,
              focusNode: item.nameFocusNode,
              textInputAction: TextInputAction.next,
            ),
          ),
          ReceiptItemsFormTable._bodyCell(
            width: ReceiptItemsFormTable._codeWidth,
            child: TableInput(
              controller: item.codeController,
              focusNode: item.codeFocusNode,
              textInputAction: TextInputAction.next,
            ),
          ),
          ReceiptItemsFormTable._bodyCell(
            width: ReceiptItemsFormTable._unitWidth,
            child: TableInput(
              controller: item.unitController,
              focusNode: item.unitFocusNode,
              textInputAction: TextInputAction.next,
            ),
          ),
          ReceiptItemsFormTable._bodyCell(
            width: ReceiptItemsFormTable._quantityColumnWidth,
            child: TableInput(
              controller: item.quantityDocumentController,
              focusNode: item.quantityDocumentFocusNode,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              onChanged: (_) => onChanged(),
            ),
          ),
          ReceiptItemsFormTable._bodyCell(
            width: ReceiptItemsFormTable._quantityColumnWidth,
            child: TableInput(
              controller: item.quantityReceivedController,
              focusNode: item.quantityReceivedFocusNode,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              onChanged: (_) => onChanged(),
            ),
          ),
          ReceiptItemsFormTable._bodyCell(
            width: ReceiptItemsFormTable._priceWidth,
            child: Focus(
              onKeyEvent: (_, event) => _handleLastFieldTab(context, event),
              child: TableInput(
                controller: item.unitPriceController,
                focusNode: item.unitPriceFocusNode,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.right,
                textInputAction: TextInputAction.next,
                onChanged: (_) => onChanged(),
              ),
            ),
          ),
          ReceiptItemsFormTable._bodyCell(
            width: ReceiptItemsFormTable._totalWidth,
            alignRight: true,
            child: Text(NumberFormat('#,###').format(item.totalPrice)),
          ),
          ReceiptItemsFormTable._bodyCell(
            width: ReceiptItemsFormTable._actionWidth,
            removeRightBorder: true,
            child: IconButton(
              onPressed: onRemove,
              icon: const Icon(Icons.delete_outline, size: 18),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
