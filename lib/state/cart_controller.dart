import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartController extends ChangeNotifier {
  final List<CartItem> items = [];

  void add(Product product, {String size = 'L', Color color = const Color(0xFFEBC1A8), int quantity = 1}) {
    final matches = items.where((item) => item.product.id == product.id && item.size == size);
    if (matches.isNotEmpty) {
      matches.first.quantity += quantity;
    } else {
      items.add(CartItem(product: product, size: size, color: color, quantity: quantity));
    }
    notifyListeners();
  }

  void increment(CartItem item) {
    item.quantity++;
    notifyListeners();
  }

  void decrement(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      items.remove(item);
    }
    notifyListeners();
  }

  double get subtotal => items.fold(0, (sum, item) => sum + item.total);
  double get shipping => 0;
  double get total => subtotal + shipping;
  int get count => items.fold(0, (sum, item) => sum + item.quantity);
  void clear() {
    items.clear();
    notifyListeners();
  }
}

final cartController = CartController();
