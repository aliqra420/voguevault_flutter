import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';
import '../../state/menu_state.dart';
import '../home/home_screen.dart';
import '../discover/discover_screen.dart';
import '../cart/cart_screen.dart';
import '../profile/profile_screen.dart';

class SideMenuScreen extends StatelessWidget {
  const SideMenuScreen({super.key, this.width});

  /// Call this to show the side menu from any screen
  static void show(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Side Menu',
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 280),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerLeft,
          // Do not pass full-screen width here so the drawer's internal
          // width calculation (~65%) is used and the underlying screen
          // remains partially visible behind the dim barrier.
          child: const SideMenuScreen(),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final slideAnimation = Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
        );

        return SlideTransition(position: slideAnimation, child: child);
      },
    );
  }

  final double? width;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    final drawerWidth = width ?? (screenWidth * 0.65);
    final scale = (screenWidth / 390).clamp(0.82, 1.12);

    return Material(
      color: Colors.transparent,
      child: Container(
        width: drawerWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30 * scale),
            bottomRight: Radius.circular(30 * scale),
          ),
        ),
        child: SafeArea(
          right: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18 * scale, vertical: 20 * scale),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 53 * scale,
                        height: 53 * scale,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFF3A0A4),
                          border: Border.all(color: const Color(0xFFF3A0A4), width: 1),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            AppAssets.userLogo,
                            width: 53 * scale,
                            height: 53 * scale,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      SizedBox(width: 12 * scale),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Al Iqra', style: TextStyle(fontSize: 15 * scale, fontWeight: FontWeight.w600, color: const Color(0xFF17171B))),
                            SizedBox(height: 4 * scale),
                            Text('aliqra420s@gmail.com', style: TextStyle(fontSize: 11 * scale, fontWeight: FontWeight.w400, color: const Color(0xFF7A8195))),
                          ],
                        ),
                      ),
                    ],
                  ),

                      SizedBox(height: 28 * scale),

                  ValueListenableBuilder<int>(
                    valueListenable: sideMenuIndex,
                    builder: (context, selectedIndex, _) {
                      return Column(
                        children: [
                          _MenuItem(icon: Icons.home_outlined, title: 'Homepage', selected: false, scale: scale, image: AppAssets.homeLogo, onTap: () {
                            final navigator = Navigator.of(context);
                            navigator.pop();
                            navigator.pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen(), settings: const RouteSettings(name: 'home')));
                          }),
                          SizedBox(height: 6 * scale),
                          _MenuItem(icon: Icons.search_rounded, title: 'Discover', selected: false, scale: scale, image: AppAssets.discoverLogo, onTap: () {
                            final navigator = Navigator.of(context);
                            navigator.pop();
                            navigator.pushReplacement(MaterialPageRoute(builder: (_) => const DiscoverScreen(), settings: const RouteSettings(name: 'discover')));
                          }),
                          SizedBox(height: 6 * scale),
                          _MenuItem(icon: Icons.shopping_bag_outlined, title: 'My Order', selected: false, scale: scale, image: AppAssets.myOrderLogo, onTap: () {
                            final navigator = Navigator.of(context);
                            navigator.pop();
                            navigator.pushReplacement(MaterialPageRoute(builder: (_) => const CartScreen(), settings: const RouteSettings(name: 'cart')));
                          }),
                          SizedBox(height: 6 * scale),
                          _MenuItem(icon: Icons.person_outline_rounded, title: 'My profile', selected: false, scale: scale, image: AppAssets.profileLogo, onTap: () {
                            final navigator = Navigator.of(context);
                            navigator.pop();
                            navigator.pushReplacement(MaterialPageRoute(builder: (_) => const ProfileScreen(), settings: const RouteSettings(name: 'profile')));
                          }),
                        ],
                      );
                    },
                  ),

                  SizedBox(height: 22 * scale),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6 * scale, vertical: 8 * scale),
                    child: Text('OTHER', style: TextStyle(fontSize: 13 * scale, fontWeight: FontWeight.w400, color: const Color(0xFF7A8195))),
                  ),

                  _MenuItem(icon: Icons.settings_outlined, title: 'Setting', scale: scale, image: AppAssets.settingLogo, onTap: () => Navigator.of(context).pop()),
                  SizedBox(height: 6 * scale),
                  _MenuItem(icon: Icons.mail_outline_rounded, title: 'Support', scale: scale, image: AppAssets.supportLogo, onTap: () => Navigator.of(context).pop()),
                  SizedBox(height: 6 * scale),
                  _MenuItem(icon: Icons.info_outline_rounded, title: 'About us', scale: scale, image: AppAssets.aboutLogo, onTap: () => Navigator.of(context).pop()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool selected;
  final double scale;
  final VoidCallback onTap;
  final String? image;

  const _MenuItem({required this.icon, required this.title, required this.scale, required this.onTap, this.selected = false, this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 52 * scale,
        padding: EdgeInsets.symmetric(horizontal: 6 * scale),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFF5F5F6) : Colors.transparent,
          borderRadius: BorderRadius.circular(8 * scale),
        ),
        child: Row(
          children: [
            // left indicator
            Container(
              width: 4 * scale,
              height: 32 * scale,
              decoration: BoxDecoration(
                color: selected ? const Color(0xFF111111) : Colors.transparent,
                borderRadius: BorderRadius.circular(2 * scale),
              ),
            ),
            SizedBox(width: 10 * scale),
            SizedBox(
              width: 40 * scale,
              child: Center(
                child: image != null
                    ? Image.asset(image!, width: 22 * scale, height: 22 * scale, fit: BoxFit.contain)
                    : Icon(icon, size: 22 * scale, color: selected ? const Color(0xFF111111) : const Color(0xFF778097)),
              ),
            ),
            SizedBox(width: 12 * scale),
            Expanded(child: Text(title, style: TextStyle(fontSize: 15 * scale, fontWeight: selected ? FontWeight.w600 : FontWeight.w500, color: selected ? const Color(0xFF111111) : const Color(0xFF778097)))),
          ],
        ),
      ),
    );
  }
}