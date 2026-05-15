import 'package:flutter/material.dart';

class ReceiptActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ReceiptActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,

      icon: Icon(icon),

      label: Text(label),

      style: OutlinedButton.styleFrom(minimumSize: const Size(0, 52)),
    );
  }
}
