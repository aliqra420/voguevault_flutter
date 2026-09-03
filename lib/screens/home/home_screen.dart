import 'package:flutter/material.dart';

import '../../core/utils/responsive.dart';
import '../discover/discover_screen.dart';
import '../cart/cart_screen.dart';
import '../profile/profile_screen.dart';
import '../../widgets/home/category_row.dart';
import '../../widgets/home/feature_products.dart';
import '../../widgets/home/men_hero_banner.dart';
import '../../widgets/home/home_bottom_nav.dart';
import '../product/show_all_products_screen.dart';
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
  String selectedCategory = 'Women';

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

            // HERO / COLLECTION (mixed across Women, Men, Accessories, and Beauty)
            SliverToBoxAdapter(
              child: MenHeroBanner(category: selectedCategory),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 25 * s),
            ),

            // WOMEN / MEN / ACCESSORIES / BEAUTY
            SliverToBoxAdapter(
              child: CategoryRow(
                selectedCategory: selectedCategory,
                onChanged: (c) => setState(() => selectedCategory = c),
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 40 * s),
            ),

            // FEATURE PRODUCTS TITLE
            SliverToBoxAdapter(
              child: SectionTitle(
                title: 'Feature Products',
                onShowAll: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ShowAllProductsScreen(
                      section: 'Feature',
                      category: selectedCategory,
                    ),
                  ),
                ),
              ),
            ),

            // FEATURE PRODUCTS
            SliverToBoxAdapter(
              child: FeatureProducts(category: selectedCategory),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 15 * s),
            ),

            // PARTY BANNER (only for Women category)
            if (selectedCategory == 'Women') ...[
              const SliverToBoxAdapter(
                child: PartyBanner(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 43 * s),
              ),
            ],

            // RECOMMENDED
            SliverToBoxAdapter(
              child: SectionTitle(
                title: 'Recommended',
                onShowAll: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ShowAllProductsScreen(
                      section: 'Recommended',
                      category: selectedCategory,
                    ),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: RecommendedProducts(category: selectedCategory),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 42 * s),
            ),

            // TOP COLLECTION
            SliverToBoxAdapter(
              child: SectionTitle(
                title: 'Top Collection',
                onShowAll: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ShowAllProductsScreen(
                      section: 'Top Collection',
                      category: selectedCategory,
                    ),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: TopCollection(category: selectedCategory),
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