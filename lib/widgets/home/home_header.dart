import 'package:flutter/material.dart';
// removed google_fonts - using default TextStyle

import '../../core/utils/responsive.dart';
import '../../core/constants/app_assets.dart';
import '../../screens/side_menu/side_menu_screen.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final s = Responsive.scale(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        36 * s,
        16 * s,
        25 * s,
        4 * s,
      ),
      child: Row(
        children: [

          // MENU (use navbar logo image)
          GestureDetector(
            onTap: () => SideMenuScreen.show(context),
            child: Image.asset(
              AppAssets.navbarLogo,
              width: 18 * s,
              height: 18 * s,
              fit: BoxFit.contain,
            ),
          ),

          const Spacer(),

          // LOGO
          Text(
            'VOGUEVAULT',
            style: TextStyle(
              fontSize: Responsive.font(context, 17),
              fontWeight: FontWeight.w400,
              letterSpacing: -0.3,
              color: Colors.black,
            ),
          ),

          const Spacer(),

          // NOTIFICATION
          Stack(
            clipBehavior: Clip.none,
            children: [

              Icon(
                Icons.notifications_none_rounded,
                size: 30 * s,
                color: Colors.black,
              ),

              Positioned(
                right: 0,
                top: -1 * s,
                child: Container(
                  width: 8 * s,
                  height: 8 * s,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE83F6F),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}