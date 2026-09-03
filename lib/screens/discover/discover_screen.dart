import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../data/products.dart';
import '../../models/product.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/product_card.dart';

class DiscoverScreen extends StatefulWidget { const DiscoverScreen({super.key}); @override State<DiscoverScreen> createState() => _DiscoverState(); }
class _DiscoverState extends State<DiscoverScreen> {
  String query = '';
  String category = 'All';
  double maxPrice = 100;
  final List<Product> _dynamic = [];

  List<Product> get allProducts => [...products, ..._dynamic];

  List get filtered => allProducts.where((p) {
        final matchesCategory =
            category == 'All' ||
            (category == 'Women' && (p.category == 'Women' || p.category == 'Dresses')) ||
            (category != 'Women' && category != 'All' && p.category == category);
        final matchesPrice = p.price <= maxPrice;
        final matchesQuery = p.name.toLowerCase().contains(query.toLowerCase());
        return matchesCategory && matchesPrice && matchesQuery;
      }).toList();

  @override
  void initState() {
    super.initState();
    // Immediate debug: report static products count (helps if manifest fails)
    try { print('Discover.init: static products=${products.length}'); } catch (_) {}
    _loadAssetProducts();
  }

  Future<void> _loadAssetProducts() async {
    try {
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      final assetKeys = manifestMap.keys.where((k) => k.startsWith('assets/images/men/') || k.startsWith('assets/images/accessories/') || k.startsWith('assets/images/beauty/'));
      int counter = 1;
      for (final key in assetKeys) {
        // skip if a static product already references this image (avoid duplicates)
        if (products.any((p) => p.image == key)) continue;
        final parts = key.split('/');
        final file = parts.isNotEmpty ? parts.last : key;
        final name = _titleFromFile(file);
        String categoryFromPath;
        if (key.contains('/men/')) {
          categoryFromPath = 'Men';
        } else if (key.contains('/beauty/')) {
          categoryFromPath = 'Beauty';
        } else {
          categoryFromPath = 'Accessories';
        }
        // demo price ranges (customized): Men 59-129, Accessories 9-59, Beauty 15-79
        final price = categoryFromPath == 'Men'
          ? (59 + (counter * 11) % 71).toDouble()
          : categoryFromPath == 'Beauty'
            ? (15 + (counter * 8) % 65).toDouble()
            : (9 + (counter * 10) % 51).toDouble();
        _dynamic.add(Product(id: key, name: name, price: price, image: key, category: categoryFromPath));
        counter++;
      }
      setState(() {});
      // Debug logs: show counts and samples to help diagnose empty results
      try {
        print('Discover: total products=${allProducts.length}, dynamic=${_dynamic.length}');
        for (var i = 0; i < allProducts.length && i < 6; i++) {
          final p = allProducts[i];
          print(' product[$i] id=${p.id} name=${p.name} category=${p.category} price=${p.price} image=${p.image}');
        }
      } catch (_) {}
    } catch (_) {
      // ignore errors silently; leave dynamic list empty
    }
  }

  String _titleFromFile(String fileName) {
    final noExt = fileName.split('.').first;
    final cleaned = noExt.replaceAll(RegExp(r'[_\-]'), ' ');
    return cleaned.splitMapJoin(RegExp(r"\b\w"), onMatch: (m) => m.group(0)!.toUpperCase(), onNonMatch: (n) => n).trim();
  }
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Discover')), body: SafeArea(child: Column(children: [
    // Debug: show current filter state whenever build runs
    Builder(builder: (_) { try { print('Discover.build: category=$category query="${query}" maxPrice=$maxPrice filtered=${filtered.length}'); } catch (_) {} return const SizedBox.shrink(); }),
    Padding(padding: const EdgeInsets.fromLTRB(22, 8, 22, 12), child: TextField(onChanged: (v) => setState(() => query = v), decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search products...'))),
    SizedBox(
      height: 42,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final c = ['All', 'Women', 'Men', 'Accessories', 'Beauty'][i];
          return ChoiceChip(label: Text(c), selected: category == c, onSelected: (_) => setState(() => category = c));
        },
      ),
    ),
    Padding(padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10), child: Row(children: [const Text('Price'), Expanded(child: Slider(value: maxPrice, min: 40, max: 100, divisions: 12, label: '\$${maxPrice.toStringAsFixed(0)}', onChanged: (v) => setState(() => maxPrice = v))), Text('\$${maxPrice.toStringAsFixed(0)}')])),
    Expanded(child: filtered.isEmpty ? const Center(child: Text('No products found')) : GridView.builder(padding: const EdgeInsets.fromLTRB(22, 10, 22, 22), itemCount: filtered.length, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 14, mainAxisSpacing: 18, childAspectRatio: .67), itemBuilder: (_, i) => ProductCard(product: filtered[i]))),
  ])), bottomNavigationBar: const BottomNav(index: 1));
}
