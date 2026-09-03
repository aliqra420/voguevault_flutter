import 'package:flutter/material.dart';
// removed google_fonts - using default TextStyle

import 'dart:convert';

import '../../core/constants/app_assets.dart';
import '../../core/utils/responsive.dart';
import '../../data/products.dart';
import '../../models/product.dart';
import '../../screens/product/product_details_screen.dart';

class TopCollection extends StatefulWidget {
  final String category;

  const TopCollection({super.key, this.category = 'Women'});

  @override
  State<TopCollection> createState() => _TopCollectionState();
}

class _TopCollectionState extends State<TopCollection> {
  List<String> dynamicImages = [];

  @override
  void initState() {
    super.initState();
    _loadAssetsForCategory();
  }

  @override
  void didUpdateWidget(covariant TopCollection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.category != widget.category) {
      dynamicImages = [];
      _loadAssetsForCategory();
    }
  }

  Future<void> _loadAssetsForCategory() async {
    try {
      final manifestContent = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      final prefix = 'assets/images/${widget.category.toLowerCase()}/';
      final keys = manifestMap.keys.where((k) => k.startsWith(prefix)).toList();
      setState(() {
        dynamicImages = keys;
      });
    } catch (_) {
      // ignore
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = Responsive.scale(context);

    final filtered = products.where((p) => p.category == widget.category).toList();

    String _imgAt(int i, String fallback) {
      if (i >= 0 && i < filtered.length) return filtered[i].image;
      if (i >= 0 && i < dynamicImages.length) return dynamicImages[i];
      return fallback;
    }

    String formattedTitle(String cat) {
      return 'Autumn\n${cat}\nCollection';
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 37 * s,
        ),
        child: Column(
          children: [
            if (widget.category == 'Men') ...[
              // For Men: show a single large hero and a pair of small cards (hide the "New Collection" large banner)
              _LargeCollectionCard(
                product: products.firstWhere((p) => p.category == 'Men', orElse: () => Product(id: 'f1', name: 'Mens Premium', price: 0, image: AppAssets.productDress, category: 'Men')),
                image: products.firstWhere((p) => p.category == 'Men', orElse: () => Product(id: 'f1', name: '', price: 0, image: AppAssets.productDress, category: 'Men')).image,
                smallText: 'New Arrival',
                title: formattedTitle('Men'),
                titleSize: 20,
                height: 160,
              ),

              SizedBox(height: 18 * s),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _SmallCollectionCard(
                      product: products.firstWhere((p) => p.category == 'Men' && p.image.contains('Contemporary'), orElse: () => Product(id: 'f3', name: 'Casual Wear', price: 0, image: AppAssets.office, category: 'Men')),
                      image: products.firstWhere((p) => p.category == 'Men' && p.image.contains('Contemporary'), orElse: () => Product(id: 'f3', name: '', price: 0, image: AppAssets.office, category: 'Men')).image,
                      category: 'T-Shirts',
                      title: 'Casual\nWear',
                    ),
                  ),

                  SizedBox(width: 12 * s),

                  Expanded(
                    child: _SmallCollectionCard(
                      product: products.firstWhere((p) => p.category == 'Men' && p.image.contains('Denim'), orElse: () => Product(id: 'f4', name: 'Denim Classics', price: 0, image: AppAssets.elegant, category: 'Men')),
                      image: products.firstWhere((p) => p.category == 'Men' && p.image.contains('Denim'), orElse: () => Product(id: 'f4', name: '', price: 0, image: AppAssets.elegant, category: 'Men')).image,
                      category: 'Jeans',
                      title: 'Denim\nClassics',
                    ),
                  ),
                ],
              ),
            ] else if (widget.category == 'Accessories') ...[
              // Accessories: use the Men layout but pull images from accessories products
              _LargeCollectionCard(
                product: Product(id: 'top-accessories-1', name: 'Accessories Collection', price: 49, image: _imgAt(0, AppAssets.productDress), category: 'Accessories', rating: 4.8, reviews: 120),
                image: _imgAt(0, AppAssets.productDress),
                smallText: 'New Arrival',
                title: formattedTitle('Accessories'),
                titleSize: 20,
                height: 160,
              ),

              SizedBox(height: 18 * s),

              _LargeCollectionCard(
                product: Product(id: 'top-accessories-2', name: 'Smart & Stylish', price: 59, image: _imgAt(1, AppAssets.fabulous), category: 'Accessories', rating: 4.7, reviews: 98),
                image: _imgAt(1, AppAssets.fabulous),
                smallText: 'New Collection',
                title: 'Smart\n& Stylish',
                titleSize: 20,
                height: 242,
              ),

              SizedBox(height: 18 * s),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _SmallCollectionCard(
                      product: Product(id: 'top-accessories-3', name: 'Everyday Essentials', price: 39, image: _imgAt(2, AppAssets.office), category: 'Accessories', rating: 4.6, reviews: 90),
                      image: _imgAt(2, AppAssets.office),
                      category: 'Trending',
                      title: 'Everyday\nEssentials',
                    ),
                  ),

                  SizedBox(width: 12 * s),

                  Expanded(
                    child: _SmallCollectionCard(
                      product: Product(id: 'top-accessories-4', name: 'Must Have', price: 44, image: _imgAt(3, AppAssets.elegant), category: 'Accessories', rating: 4.8, reviews: 89),
                      image: _imgAt(3, AppAssets.elegant),
                      category: 'Top Picks',
                      title: 'Must\nHave',
                    ),
                  ),
                ],
              ),
            ] else if (widget.category == 'Beauty') ...[
              _LargeCollectionCard(
                product: Product(id: 'top-beauty-1', name: 'Beauty Collection', price: 59, image: _imgAt(0, AppAssets.slimBeauty), category: 'Beauty', rating: 4.9, reviews: 140),
                image: _imgAt(0, AppAssets.slimBeauty),
                smallText: 'New Arrival',
                title: formattedTitle('Beauty'),
                titleSize: 20,
                height: 160,
                imageOnRight: true,
              ),

              SizedBox(height: 18 * s),

              _LargeCollectionCard(
                product: Product(id: 'top-beauty-2', name: 'Glow & Care', price: 64, image: _imgAt(1, AppAssets.fabulous), category: 'Beauty', rating: 4.8, reviews: 126),
                image: _imgAt(1, AppAssets.fabulous),
                smallText: 'New Collection',
                title: 'Glow\n& Care',
                titleSize: 20,
                height: 242,
                imageOnRight: true,
              ),

              SizedBox(height: 18 * s),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _SmallCollectionCard(
                      product: Product(id: 'top-beauty-3', name: 'Daily Rituals', price: 35, image: _imgAt(2, AppAssets.office), category: 'Beauty', rating: 4.7, reviews: 95),
                      image: _imgAt(2, AppAssets.office),
                      category: 'Skincare',
                      title: 'Daily\nRituals',
                      imageOnRight: true,
                    ),
                  ),

                  SizedBox(width: 12 * s),

                  Expanded(
                    child: _SmallCollectionCard(
                      product: Product(id: 'top-beauty-4', name: 'Top Picks', price: 42, image: _imgAt(3, AppAssets.elegant), category: 'Beauty', rating: 4.9, reviews: 118),
                      image: _imgAt(3, AppAssets.elegant),
                      category: 'Makeup',
                      title: 'Top\nPicks',
                      imageOnRight: true,
                    ),
                  ),
                ],
              ),
            ] else ...[
              _LargeCollectionCard(
                product: Product(id: 'top-women-1', name: 'FOR SLIM & BEAUTY', price: 89, image: AppAssets.slimBeauty, category: 'Women', rating: 4.8, reviews: 120),
                image: AppAssets.slimBeauty,
                smallText: 'Sale up to 40%',
                title: 'FOR SLIM\n& BEAUTY',
                titleSize: 20,
                height: 160,
                imageOnRight: true,
              ),

              SizedBox(height: 18 * s),

              _LargeCollectionCard(
                product: Product(id: 'top-women-2', name: 'Most sexy & fabulous design', price: 94, image: AppAssets.fabulous, category: 'Women', rating: 4.7, reviews: 98),
                image: AppAssets.fabulous,
                smallText: 'Summer Collection 2026',
                title: 'Most sexy\n& fabulous\ndesign',
                titleSize: 20,
                height: 242,
                imageOnRight: true,
              ),

              SizedBox(height: 18 * s),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _SmallCollectionCard(
                      product: Product(id: 'top-women-3', name: 'The Office Life', price: 75, image: AppAssets.office, category: 'Women', rating: 4.6, reviews: 88),
                      image: AppAssets.office,
                      category: 'T-Shirts',
                      title: 'The\nOffice\nLife',
                      imageOnRight: true,
                    ),
                  ),

                  SizedBox(width: 12 * s),

                  Expanded(
                    child: _SmallCollectionCard(
                      product: Product(id: 'top-women-4', name: 'Elegant Design', price: 82, image: AppAssets.elegant, category: 'Women', rating: 4.9, reviews: 115),
                      image: AppAssets.elegant,
                      category: 'Dresses',
                      title: 'Elegant\nDesign',
                      imageOnRight: true,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}


// =====================================================
// LARGE COLLECTION CARD
// =====================================================

class _LargeCollectionCard extends StatelessWidget {
  final Product? product;
  final String image;
  final String smallText;
  final String title;
  final double titleSize;
  final double height;
  final bool imageOnRight;

  const _LargeCollectionCard({
    this.product,
    required this.image,
    required this.smallText,
    required this.title,
    required this.titleSize,
    required this.height,
    this.imageOnRight = false,
  });

  @override
  Widget build(BuildContext context) {
    final s = Responsive.scale(context);

    final textWidget = Padding(
      padding: EdgeInsets.fromLTRB(25 * s, 23 * s, 18 * s, 18 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '|  $smallText',
            style: TextStyle(
              fontSize: Responsive.font(context, 11.5),
              fontWeight: FontWeight.w400,
              color: const Color(0xFF92929A),
            ),
          ),
          SizedBox(height: 18 * s),
          Text(
            title,
            style: TextStyle(
              fontSize: Responsive.font(context, titleSize),
              height: 1.28,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF4E4F5B),
            ),
          ),
        ],
      ),
    );

    final imageWidget = ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(12 * s),
        bottomRight: Radius.circular(12 * s),
      ),
      child: Image.asset(
        image,
        fit: BoxFit.cover,
      ),
    );

    final card = imageOnRight
        ? SizedBox(
            width: double.infinity,
            height: height * s,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12 * s),
              child: Container(
                color: const Color(0xFFF7F7F9),
                child: Row(
                  children: [
                    Expanded(child: textWidget),
                    Expanded(child: imageWidget),
                  ],
                ),
              ),
            ),
          )
        : SizedBox(
            width: double.infinity,
            height: height * s,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12 * s),
              child: Stack(
                children: [
                  Container(color: const Color(0xFFF7F7F9)),
                  Positioned.fill(child: Image.asset(image, fit: BoxFit.cover)),
                  Positioned(left: 25 * s, top: 23 * s, child: Text('|  $smallText', style: TextStyle(fontSize: Responsive.font(context, 11.5), fontWeight: FontWeight.w400, color: const Color(0xFF92929A)))) ,
                  Positioned(left: 25 * s, top: 68 * s, child: Text(title, style: TextStyle(fontSize: Responsive.font(context, titleSize), height: 1.28, fontWeight: FontWeight.w400, color: const Color(0xFF4E4F5B)))) ,
                ],
              ),
            ),
          );

    if (product == null) return card;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: product!)),
      ),
      child: card,
    );
  }
}

// =====================================================
// SMALL COLLECTION CARD
// =====================================================

class _SmallCollectionCard extends StatelessWidget {
  final Product? product;
  final String image;
  final String category;
  final String title;
  final bool imageOnRight;

  const _SmallCollectionCard({
    this.product,
    required this.image,
    required this.category,
    required this.title,
    this.imageOnRight = false,
  });

  @override
  Widget build(BuildContext context) {
    final s = Responsive.scale(context);

    final textWidget = Padding(
      padding: EdgeInsets.fromLTRB(18 * s, 18 * s, 12 * s, 18 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            category,
            style: TextStyle(
              fontSize: Responsive.font(context, 13),
              fontWeight: FontWeight.w400,
              color: const Color(0xFF777780),
            ),
          ),
          SizedBox(height: 12 * s),
          Text(
            title,
            style: TextStyle(
              fontSize: Responsive.font(context, 17),
              height: 1.18,
              fontWeight: FontWeight.w300,
              color: const Color(0xFF3F4049),
            ),
          ),
        ],
      ),
    );

    final card = () {
      if (imageOnRight) {
        return SizedBox(
          height: 225 * s,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12 * s),
            child: Container(
              color: const Color(0xFFF7F7F9),
              child: Row(
                children: [
                  Expanded(child: textWidget),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12 * s),
                        bottomRight: Radius.circular(12 * s),
                      ),
                      child: Image.asset(image, fit: BoxFit.cover),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      return SizedBox(
        height: 225 * s,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12 * s),
          child: Stack(
            children: [
              Container(color: const Color(0xFFF7F7F9)),
              Positioned.fill(child: Image.asset(image, fit: BoxFit.cover)),
              Positioned(left: 95 * s, top: 43 * s, child: Text(category, style: TextStyle(fontSize: Responsive.font(context, 13), fontWeight: FontWeight.w400, color: const Color(0xFF777780)))),
              Positioned(left: 95 * s, top: 87 * s, child: Text(title, style: TextStyle(fontSize: Responsive.font(context, 17), height: 1.18, fontWeight: FontWeight.w300, color: const Color(0xFF3F4049)))),
            ],
          ),
        ),
      );
    }();

    if (product == null) return card;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: product!)),
      ),
      child: card,
    );
  }
}