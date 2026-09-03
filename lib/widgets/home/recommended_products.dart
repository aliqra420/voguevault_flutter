import 'package:flutter/material.dart';
// removed google_fonts - using default TextStyle

import 'dart:convert';

import '../../core/constants/app_assets.dart';
import '../../core/utils/responsive.dart';
import '../../data/products.dart';
import '../../models/product.dart';
import '../../screens/product/product_details_screen.dart';

class RecommendedProducts extends StatefulWidget {
  final String category;

  const RecommendedProducts({super.key, this.category = 'Women'});

  @override
  State<RecommendedProducts> createState() => _RecommendedProductsState();
}

class _RecommendedProductsState extends State<RecommendedProducts> {
  List<String> dynamicImages = [];

  @override
  void initState() {
    super.initState();
    _loadAssetsForCategory();
  }

  @override
  void didUpdateWidget(covariant RecommendedProducts oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.category != widget.category) {
      dynamicImages = [];
      _loadAssetsForCategory();
    }
  }

  Future<void> _loadAssetsForCategory() async {
    try {
      final manifestContent = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      final prefix = 'assets/images/${widget.category.toLowerCase()}/';
      final keys = manifestMap.keys.where((k) => k.startsWith(prefix)).toList();
      setState(() => dynamicImages = keys);
    } catch (_) {}
  }

  String _titleFromFile(String fileName) {
    final noExt = fileName.split('.').first;
    final cleaned = noExt.replaceAll(RegExp(r'[_\-]'), ' ');
    return cleaned.splitMapJoin(RegExp(r"\b\w"), onMatch: (m) => m.group(0)!.toUpperCase(), onNonMatch: (n) => n).trim();
  }

  @override
  Widget build(BuildContext context) {
    final s = Responsive.scale(context);
    final filtered = widget.category == 'Women'
        ? products.where((p) => p.category == 'Women' || p.category == 'Dresses').toList()
        : products.where((p) => p.category == widget.category).toList();

    final items = filtered.isNotEmpty
        ? (filtered.length > 3
            ? filtered.skip(1).take(3).toList()
            : filtered.take(3).toList())
        : (dynamicImages.isNotEmpty
            ? dynamicImages.take(3).map((k) {
                final file = k.split('/').last;
                return Product(
                  id: 'dynamic-recommended-${file}',
                  name: _titleFromFile(file),
                  price: 29.99,
                  image: k,
                  category: widget.category,
                );
              }).toList()
            : [
                const Product(
                  id: 'recommended-fallback',
                  name: 'Fallback Hoodie',
                  price: 29.00,
                  image: AppAssets.hoodie,
                  category: 'Women',
                )
              ]);

    return SizedBox(
      height: 270 * s,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 39 * s),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (_, __) => SizedBox(width: 23 * s),
        itemBuilder: (context, index) {
          final product = items[index];
          final cardWidth = 145 * s;
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: product)),
            ),
            child: SizedBox(
              width: cardWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(11 * s),
                    child: SizedBox(
                      width: cardWidth,
                      height: 197 * s,
                      child: Image.asset(product.image, fit: BoxFit.cover),
                    ),
                  ),

                  SizedBox(height: 12 * s),

                  Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: Responsive.font(context, 12.5), fontWeight: FontWeight.w400, color: const Color(0xFF222229))),

                  SizedBox(height: 4 * s),

                  Text('\$ ${product.price.toStringAsFixed(2)}', style: TextStyle(fontSize: Responsive.font(context, 17), fontWeight: FontWeight.w600, color: const Color(0xFF15151A))),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
