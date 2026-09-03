import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../models/product.dart';
import '../../state/cart_controller.dart';
import '../../widgets/app_button.dart';
import '../../widgets/quantity_selector.dart';
import '../cart/cart_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetailsScreen> {
  String size = 'M';
  int quantity = 1;
  Color selectedColor = const Color(0xFFEBC1A8);
  bool wish = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        actions: [
          IconButton(
            onPressed: () => setState(() => wish = !wish),
            icon: Icon(
              wish ? Icons.favorite : Icons.favorite_border,
              color: wish ? AppColors.coral : null,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen())),
            icon: const Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(22, 8, 22, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        color: AppColors.soft,
                        height: 420,
                        width: double.infinity,
                        child: Image.asset(widget.product.image, fit: BoxFit.contain),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.product.name,
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Text('\$${widget.product.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('★★★★★  ${widget.product.rating.toStringAsFixed(1)}  (${widget.product.reviews} reviews)', style: const TextStyle(color: AppColors.green)),
                    const SizedBox(height: 22),
                    const Text('Colour', style: TextStyle(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        for (final c in [const Color(0xFFEBC1A8), const Color(0xFF222222), const Color(0xFFE6E2D8)])
                          GestureDetector(
                            onTap: () => setState(() => selectedColor = c),
                            child: Container(
                              margin: const EdgeInsets.only(right: 12),
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: c,
                                shape: BoxShape.circle,
                                border: Border.all(color: selectedColor == c ? AppColors.coral : Colors.transparent, width: 3),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        const Expanded(child: Text('Size', style: TextStyle(fontWeight: FontWeight.w700))),
                        for (final s in ['S', 'M', 'L', 'XL'])
                          Padding(
                            padding: const EdgeInsets.only(left: 7),
                            child: ChoiceChip(
                              label: Text(s),
                              selected: size == s,
                              onSelected: (_) => setState(() => size = s),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        const Text('Quantity', style: TextStyle(fontWeight: FontWeight.w700)),
                        const Spacer(),
                        QuantitySelector(
                          quantity: quantity,
                          onMinus: () => setState(() {
                            if (quantity > 1) quantity--;
                          }),
                          onPlus: () => setState(() => quantity++),
                        ),
                      ],
                    ),
                    const Divider(height: 34),
                    const Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    const Text(
                      'A comfortable fashion piece designed for everyday style. Premium feel, relaxed fit and easy to pair with your favourite wardrobe essentials.',
                      style: TextStyle(color: AppColors.muted, height: 1.5),
                    ),
                    const SizedBox(height: 22),
                    const Text('Reviews', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 10),
                    const Text('★★★★★\n“Beautiful quality and exactly as pictured.”', style: TextStyle(color: AppColors.green, height: 1.7)),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(22, 12, 22, 14),
              decoration: const BoxDecoration(color: AppColors.dark, borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        label: 'ADD TO CART',
                        onPressed: () {
                          cartController.add(widget.product, size: size, color: selectedColor, quantity: quantity);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart')));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
