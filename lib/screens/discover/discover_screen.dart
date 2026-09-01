import 'package:flutter/material.dart';
// import '../../core/theme/app_theme.dart'; // unused
import '../../data/products.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/product_card.dart';

class DiscoverScreen extends StatefulWidget { const DiscoverScreen({super.key}); @override State<DiscoverScreen> createState() => _DiscoverState(); }
class _DiscoverState extends State<DiscoverScreen> {
  String query = '';
  String category = 'All';
  double maxPrice = 100;
  List get filtered => products.where((p) => (category == 'All' || p.category == category || (category == 'Dresses' && p.category == 'Dresses')) && p.price <= maxPrice && p.name.toLowerCase().contains(query.toLowerCase())).toList();
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Discover')), body: SafeArea(child: Column(children: [
    Padding(padding: const EdgeInsets.fromLTRB(22, 8, 22, 12), child: TextField(onChanged: (v) => setState(() => query = v), decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search products...'))),
    SizedBox(height: 42, child: ListView.separated(padding: const EdgeInsets.symmetric(horizontal: 22), scrollDirection: Axis.horizontal, itemCount: 4, separatorBuilder: (_, __) => const SizedBox(width: 8), itemBuilder: (_, i) { final c = ['All','Women','Dresses','Men'][i]; return ChoiceChip(label: Text(c), selected: category == c, onSelected: (_) => setState(() => category = c)); })),
    Padding(padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10), child: Row(children: [const Text('Price'), Expanded(child: Slider(value: maxPrice, min: 40, max: 100, divisions: 12, label: '\$${maxPrice.toStringAsFixed(0)}', onChanged: (v) => setState(() => maxPrice = v))), Text('\$${maxPrice.toStringAsFixed(0)}')])),
    Expanded(child: filtered.isEmpty ? const Center(child: Text('No products found')) : GridView.builder(padding: const EdgeInsets.fromLTRB(22, 10, 22, 22), itemCount: filtered.length, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 14, mainAxisSpacing: 18, childAspectRatio: .67), itemBuilder: (_, i) => ProductCard(product: filtered[i]))),
  ])), bottomNavigationBar: const BottomNav(index: 1));
}
