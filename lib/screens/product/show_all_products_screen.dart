import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import '../../data/products.dart';
import '../../models/product.dart';
import '../../widgets/product_card.dart';

class ShowAllProductsScreen extends StatefulWidget {
  final String section;
  final String category;

  const ShowAllProductsScreen({
    super.key,
    required this.section,
    required this.category,
  });

  @override
  State<ShowAllProductsScreen> createState() => _ShowAllProductsScreenState();
}

class _ShowAllProductsScreenState extends State<ShowAllProductsScreen> {
  late String selectedCategory;

  static const List<String> categories = ['Women', 'Men', 'Accessories', 'Beauty'];

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.category;
  }

  List<Product> _topCollectionProductsFor(String category) {
    switch (category) {
      case 'Women':
        return [
          Product(id: 'top-women-1', name: 'Slim Beauty', price: 89, image: AppAssets.slimBeauty, category: 'Women', rating: 4.8, reviews: 120),
          Product(id: 'top-women-2', name: 'Fabulous Design', price: 94, image: AppAssets.fabulous, category: 'Women', rating: 4.7, reviews: 98),
          Product(id: 'top-women-3', name: 'Office Life', price: 75, image: AppAssets.office, category: 'Women', rating: 4.6, reviews: 88),
          Product(id: 'top-women-4', name: 'Elegant Design', price: 82, image: AppAssets.elegant, category: 'Women', rating: 4.9, reviews: 115),
        ];
      case 'Men':
        return products.where((p) => p.category == 'Men').take(4).toList();
      case 'Accessories':
        return products.where((p) => p.category == 'Accessories').take(4).toList();
      case 'Beauty':
        return products.where((p) => p.category == 'Beauty').take(4).toList();
      default:
        return [];
    }
  }

  List<Product> _filteredProductsFor(String category) {
    List<Product> source = category == 'Women'
        ? products.where((p) => p.category == 'Women' || p.category == 'Dresses').toList()
        : products.where((p) => p.category == category).toList();

    if (widget.section == 'Feature') {
      return source.take(4).toList();
    }

    if (widget.section == 'Recommended') {
      if (source.length > 3) {
        return source.skip(1).take(3).toList();
      }
      return source.take(3).toList();
    }

    if (widget.section == 'Top Collection') {
      return _topCollectionProductsFor(category);
    }

    return source;
  }

  @override
  Widget build(BuildContext context) {
    final productsForCategory = _filteredProductsFor(selectedCategory);
    final title = switch (widget.section) {
      'Recommended' => 'Recommended Products',
      'Top Collection' => 'Top Collection',
      _ => 'Feature Products',
    };

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(title),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            SizedBox(
              height: 42,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category;
                  return ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() => selectedCategory = category);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: productsForCategory.isEmpty
                  ? const Center(child: Text('No products found'))
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
                      itemCount: productsForCategory.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 18,
                        childAspectRatio: .67,
                      ),
                      itemBuilder: (_, index) => ProductCard(product: productsForCategory[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
