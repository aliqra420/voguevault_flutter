import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../state/cart_controller.dart';
import '../../widgets/app_button.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/quantity_selector.dart';
import '../checkout/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Your Cart'), leading: const BackButton()), body: SafeArea(child: AnimatedBuilder(animation: cartController, builder: (_, __) {
    if (cartController.items.isEmpty) return const Center(child: Text('Your cart is empty'));
    return Column(children: [Expanded(child: ListView.separated(padding: const EdgeInsets.all(22), itemCount: cartController.items.length, separatorBuilder: (_, __) => const SizedBox(height: 18), itemBuilder: (_, i) { final item = cartController.items[i]; return Row(children: [ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset(item.product.image, width: 82, height: 100, fit: BoxFit.cover)), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(item.product.name, style: const TextStyle(fontWeight: FontWeight.w700)), const SizedBox(height: 5), Text('Size: ${item.size}', style: const TextStyle(color: AppColors.muted, fontSize: 11)), const SizedBox(height: 6), Text('\$${item.product.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w700)), const SizedBox(height: 8), QuantitySelector(quantity: item.quantity, onMinus: () => cartController.decrement(item), onPlus: () => cartController.increment(item))]))]); })),
      Container(padding: const EdgeInsets.fromLTRB(22, 18, 22, 22), decoration: const BoxDecoration(color: AppColors.soft, borderRadius: BorderRadius.vertical(top: Radius.circular(24))), child: Column(children: [const Row(children: [Expanded(child: Text('Promo code', style: TextStyle(color: AppColors.muted))), Text('APPLY', style: TextStyle(color: AppColors.coral, fontWeight: FontWeight.w700))]), const Divider(height: 24), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Subtotal', style: TextStyle(color: AppColors.muted)), Text('\$${cartController.subtotal.toStringAsFixed(2)}')]), const SizedBox(height: 7), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Shipping', style: TextStyle(color: AppColors.muted)), Text('\$${cartController.shipping.toStringAsFixed(2)}')]), const Divider(height: 22), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Total', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700)), Text('\$${cartController.total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700))]), const SizedBox(height: 14), AppButton(label: 'PROCEED TO CHECKOUT', onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckoutScreen()))) ]))]);
  })), bottomNavigationBar: const BottomNav(index: 2));
}
