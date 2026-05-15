import 'package:flutter/material.dart';

class ReceiptDatePartsInput extends StatefulWidget {
  final TextEditingController controller;
  final String firstLabel;

  const ReceiptDatePartsInput({
    super.key,
    required this.controller,
    this.firstLabel = 'Ngày',
  });

  @override
  State<ReceiptDatePartsInput> createState() => _ReceiptDatePartsInputState();
}

class _ReceiptDatePartsInputState extends State<ReceiptDatePartsInput> {
  late final TextEditingController _dayController;
  late final TextEditingController _monthController;
  late final TextEditingController _yearController;

  @override
  void initState() {
    super.initState();
    final parts = widget.controller.text.split('/');
    _dayController = TextEditingController(
      text: parts.isNotEmpty ? parts[0] : '',
    );
    _monthController = TextEditingController(
      text: parts.length > 1 ? parts[1] : '',
    );
    _yearController = TextEditingController(
      text: parts.length > 2 ? parts[2] : '',
    );
  }

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  void _syncDate() {
    final day = _dayController.text.trim();
    final month = _monthController.text.trim();
    final year = _yearController.text.trim();

    widget.controller.text = _formatDateParts(day, month, year);
  }

  void _setDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    _dayController.text = day;
    _monthController.text = month;
    _yearController.text = year;
    widget.controller.text = _formatDateParts(day, month, year);
  }

  Future<void> _pickDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: _parseVietnameseDate(widget.controller.text),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selected == null) {
      return;
    }

    _setDate(selected);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.firstLabel, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 8),
        SizedBox(
          width: 42,
          child: LineInput(
            controller: _dayController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onChanged: (_) => _syncDate(),
          ),
        ),
        const SizedBox(width: 8),
        const Text('tháng', style: TextStyle(fontSize: 18)),
        const SizedBox(width: 8),
        SizedBox(
          width: 42,
          child: LineInput(
            controller: _monthController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onChanged: (_) => _syncDate(),
          ),
        ),
        const SizedBox(width: 8),
        const Text('năm', style: TextStyle(fontSize: 18)),
        const SizedBox(width: 8),
        SizedBox(
          width: 70,
          child: LineInput(
            controller: _yearController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onChanged: (_) => _syncDate(),
          ),
        ),
        const SizedBox(width: 4),
        IconButton(
          onPressed: _pickDate,
          icon: const Icon(Icons.calendar_today_outlined, size: 18),
          tooltip: 'Chọn ngày',
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints.tightFor(width: 32, height: 32),
        ),
      ],
    );
  }
}

class DateLineInput extends StatelessWidget {
  final TextEditingController controller;

  const DateLineInput({super.key, required this.controller});

  Future<void> _pickDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: _parseVietnameseDate(controller.text),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selected == null) {
      return;
    }

    controller.text = _formatDateParts(
      selected.day.toString(),
      selected.month.toString(),
      selected.year.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.datetime,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        border: const UnderlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: () => _pickDate(context),
          icon: const Icon(Icons.calendar_today_outlined, size: 18),
          tooltip: 'Chọn ngày',
          padding: EdgeInsets.zero,
        ),
        suffixIconConstraints: const BoxConstraints.tightFor(
          width: 32,
          height: 32,
        ),
      ),
    );
  }
}

class LabelInputRow extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const LabelInputRow({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        Expanded(child: LineInput(controller: controller)),
      ],
    );
  }
}

class LineInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  const LineInput({
    super.key,
    required this.controller,
    this.focusNode,
    this.textAlign = TextAlign.left,
    this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      textAlign: textAlign,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: const TextStyle(fontSize: 16),
      decoration: const InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        border: UnderlineInputBorder(),
      ),
    );
  }
}

class TableInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextAlign textAlign;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final VoidCallback? onSubmitted;

  const TableInput({
    super.key,
    required this.controller,
    this.focusNode,
    this.keyboardType,
    this.textAlign = TextAlign.left,
    this.onChanged,
    this.textInputAction,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textAlign: textAlign,
      onChanged: onChanged,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted != null ? (_) => onSubmitted!() : null,
      decoration: const InputDecoration(
        isDense: true,
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
      ),
    );
  }
}

DateTime _parseVietnameseDate(String value) {
  final parts = value.trim().split('/');
  if (parts.length != 3) {
    return DateTime.now();
  }

  final day = int.tryParse(parts[0]);
  final month = int.tryParse(parts[1]);
  final year = int.tryParse(parts[2]);

  if (day == null || month == null || year == null) {
    return DateTime.now();
  }

  try {
    return DateTime(year, month, day);
  } catch (_) {
    return DateTime.now();
  }
}

String _formatDateParts(String day, String month, String year) {
  return [day.padLeft(2, '0'), month.padLeft(2, '0'), year].join('/');
}
