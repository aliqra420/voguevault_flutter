import 'package:flutter/material.dart';

import '../../core/utils/responsive.dart';
import '../discover/discover_screen.dart';
import '../cart/cart_screen.dart';
import '../profile/profile_screen.dart';
import '../../widgets/home/category_row.dart';
import '../../widgets/home/feature_products.dart';
import '../../widgets/home/hero_banner.dart';
import '../../widgets/home/home_bottom_nav.dart';
import '../../widgets/home/home_header.dart';
import '../../widgets/home/party_banner.dart';
import '../../widgets/home/recommended_products.dart';
import '../../widgets/home/section_title.dart';
import '../../widgets/home/top_collection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedBottomIndex = 0;

  @override
  Widget build(BuildContext context) {
    final s = Responsive.scale(context);

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [

            // HEADER
            const SliverToBoxAdapter(
              child: HomeHeader(),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 18 * s),
            ),

            // WOMEN / MEN / ACCESSORIES / BEAUTY
            const SliverToBoxAdapter(
              child: CategoryRow(),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 25 * s),
            ),

            // AUTUMN COLLECTION
            const SliverToBoxAdapter(
              child: HeroBanner(),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 40 * s),
            ),

            // FEATURE PRODUCTS TITLE
            const SliverToBoxAdapter(
              child: SectionTitle(
                title: 'Feature Products',
              ),
            ),

            // FEATURE PRODUCTS
            const SliverToBoxAdapter(
              child: FeatureProducts(),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 15 * s),
            ),

            // PARTY BANNER
            const SliverToBoxAdapter(
              child: PartyBanner(),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 43 * s),
            ),

            // RECOMMENDED
            const SliverToBoxAdapter(
              child: SectionTitle(
                title: 'Recommended',
              ),
            ),

            const SliverToBoxAdapter(
              child: RecommendedProducts(),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 42 * s),
            ),

            // TOP COLLECTION
            const SliverToBoxAdapter(
              child: SectionTitle(
                title: 'Top Collection',
              ),
            ),

            const SliverToBoxAdapter(
              child: TopCollection(),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 25 * s),
            ),
          ],
        ),
      ),

      bottomNavigationBar: HomeBottomNav(
        selectedIndex: selectedBottomIndex,
        onChanged: (index) {
          if (index == 0) {
            setState(() => selectedBottomIndex = 0);
            return;
          }

          // navigate to the selected top-level screen
          Widget page;
          if (index == 1) {
            page = const DiscoverScreen();
          } else if (index == 2) {
            page = const CartScreen();
          } else {
            page = const ProfileScreen();
          }

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
        },
      ),
    );
  }
}