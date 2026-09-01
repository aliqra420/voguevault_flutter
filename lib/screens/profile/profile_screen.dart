import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_assets.dart';
import '../../widgets/bottom_nav.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
    @override
    Widget build(BuildContext context) => Scaffold(
      body: SafeArea(
        child: Column(children: [
      const SizedBox(height: 18),
      ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 22),
        leading: CircleAvatar(radius: 28, backgroundImage: AssetImage(AppAssets.userLogo)),
        title: const Text('Al Iqra', style: TextStyle(fontWeight: FontWeight.w700)),
        subtitle: const Text('aliqra420s@gmail.com', style: TextStyle(color: AppColors.muted, fontSize: 11)),
        trailing: const Icon(Icons.edit_outlined)),
      const SizedBox(height: 12),
      Expanded(child: ListView(children: [
    _item(Icons.location_on_outlined, 'Shipping Address'), _item(Icons.credit_card_outlined, 'Payment Method'), _item(Icons.shopping_bag_outlined, 'My Orders'), _item(Icons.favorite_border, 'My Wishlist'), _item(Icons.notifications_none, 'My Notifications'), _item(Icons.settings_outlined, 'Settings'), _item(Icons.help_outline, 'Help & Support'), _item(Icons.logout, 'Log Out'),
  ]))])), bottomNavigationBar: const BottomNav(index: 3));
  static Widget _item(IconData icon, String title) => ListTile(contentPadding: const EdgeInsets.symmetric(horizontal: 24), leading: Icon(icon, size: 20, color: AppColors.muted), title: Text(title, style: const TextStyle(fontSize: 13)), trailing: const Icon(Icons.chevron_right, size: 18));
}
