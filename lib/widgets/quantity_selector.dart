import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onMinus;
  final VoidCallback onPlus;
  const QuantitySelector({super.key, required this.quantity, required this.onMinus, required this.onPlus});

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(20)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      IconButton(onPressed: onMinus, icon: const Icon(Icons.remove, size: 15)),
      Text('$quantity', style: const TextStyle(fontWeight: FontWeight.w700)),
      IconButton(onPressed: onPlus, icon: const Icon(Icons.add, size: 15)),
    ]),
  );
}
