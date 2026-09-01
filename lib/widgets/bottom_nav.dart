import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../screens/home/home_screen.dart';
import '../screens/discover/discover_screen.dart';
import '../screens/cart/cart_screen.dart';
import '../screens/profile/profile_screen.dart';

class BottomNav extends StatelessWidget {
  final int index;
  const BottomNav({super.key, required this.index});

  void _go(BuildContext context, int i) {
    if (i == index) return;
    final pages = [const HomeScreen(), const DiscoverScreen(), const CartScreen(), const ProfileScreen()];
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => pages[i]));
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: index,
      height: 68,
      backgroundColor: Colors.white,
      indicatorColor: AppColors.blush,
      onDestinationSelected: (i) => _go(context, i),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.search), label: 'Discover'),
        NavigationDestination(icon: Icon(Icons.shopping_bag_outlined), label: 'Cart'),
        NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
    );
  }
}
