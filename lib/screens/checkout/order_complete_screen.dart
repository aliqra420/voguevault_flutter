import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../state/cart_controller.dart';
import '../../widgets/app_button.dart';
import '../home/home_screen.dart';

class OrderCompleteScreen extends StatelessWidget {
	final double total;

	const OrderCompleteScreen({super.key, required this.total});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: SafeArea(
				child: Center(
					child: Padding(
						padding: const EdgeInsets.all(38),
						child: Column(
							mainAxisAlignment: MainAxisAlignment.center,
							children: [
								Container(
									width: 94,
									height: 94,
									decoration: BoxDecoration(color: AppColors.blush, borderRadius: BorderRadius.circular(28)),
									child: const Icon(Icons.check_circle_outline, size: 52, color: AppColors.green),
								),
								const SizedBox(height: 28),
								const Text('Order Confirmed!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
								const SizedBox(height: 10),
								Text(
									'Thank you for shopping with VogueVault.\nOrder #VV${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
									textAlign: TextAlign.center,
									style: const TextStyle(color: AppColors.muted, height: 1.6),
								),
								const SizedBox(height: 10),
								Text('Total: \$${total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w700)),
								const SizedBox(height: 34),
								AppButton(
									label: 'CONTINUE SHOPPING',
									onPressed: () {
										cartController.clear();
										Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomeScreen()), (_) => false);
									},
								),
							],
						),
					),
				),
			),
		);
	}
}
