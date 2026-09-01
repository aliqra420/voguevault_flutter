import 'package:flutter/material.dart';
import '../models/product.dart';
import '../core/theme/app_theme.dart';
import '../screens/product/product_details_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: product))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(color: AppColors.soft, width: double.infinity, child: Image.asset(product.image, fit: BoxFit.cover)),
          ),
        ),
        const SizedBox(height: 8),
        Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 3),
        Text('\$${product.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
      ]),
    );
  }
}
