import 'dart:convert';

import 'package:flutter/material.dart';

// removed google_fonts - using default TextStyle

import '../../core/constants/app_assets.dart';
import '../../core/utils/responsive.dart';
import '../../data/products.dart';
import '../../models/product.dart';
import '../../screens/product/product_details_screen.dart';

class FeatureProducts extends StatefulWidget {
  final String category;

  const FeatureProducts({super.key, this.category = 'Women'});

  @override
  State<FeatureProducts> createState() => _FeatureProductsState();
}

class _FeatureProductsState extends State<FeatureProducts> {
  List<String> dynamicImages = [];

  @override
  void initState() {
    super.initState();
    _loadAssetsForCategory();
  }

  @override
  void didUpdateWidget(covariant FeatureProducts oldWidget) {
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
      final prefixes = <String>[];
      if (widget.category == 'Women') {
        prefixes.addAll(['assets/images/women/', 'assets/images/dress/']);
      } else {
        prefixes.add('assets/images/${widget.category.toLowerCase()}/');
      }
      final keys = manifestMap.keys.where((k) => prefixes.any((p) => k.startsWith(p))).toList();
      setState(() => dynamicImages = keys);
    } catch (_) {
      // ignore
    }
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
      ? filtered.take(4).toList()
      : dynamicImages.isNotEmpty
          ? dynamicImages.take(3).map((path) {
              final file = path.split('/').last;
              return Product(
                id: 'dynamic-feature-${file}',
                name: _titleFromFile(file),
                price: 29.99,
                image: path,
                category: widget.category,
              );
            }).toList()
          : [
              const Product(
                id: 'feature-fallback',
                name: 'Fallback',
                price: 39.99,
                image: AppAssets.productSweater,
                category: 'Women',
              )
            ];

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
