import 'package:flutter/material.dart';
// removed google_fonts - using default TextStyle

import '../../core/constants/app_assets.dart';
import '../../core/utils/responsive.dart';

class TopCollection extends StatelessWidget {
  const TopCollection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = Responsive.scale(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 37 * s,
      ),
      child: Column(
        children: [

          // SLIM & BEAUTY
          _LargeCollectionCard(
            image: AppAssets.slimBeauty,
            smallText: 'Sale up to 40%',
            title: 'FOR SLIM\n& BEAUTY',
            titleSize: 20,
            height: 160,
          ),

          SizedBox(height: 18 * s),

          // FABULOUS
          _LargeCollectionCard(
            image: AppAssets.fabulous,
            smallText: 'Summer Collection 2021',
            title: 'Most sexy\n& fabulous\ndesign',
            titleSize: 20,
            height: 242,
          ),

          SizedBox(height: 18 * s),

          // SMALL CARDS
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Expanded(
                child: _SmallCollectionCard(
                  image: AppAssets.office,
                  category: 'T-Shirts',
                  title: 'The\nOffice\nLife',
                ),
              ),

              SizedBox(width: 12 * s),

              Expanded(
                child: _SmallCollectionCard(
                  image: AppAssets.elegant,
                  category: 'Dresses',
                  title: 'Elegant\nDesign',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// =====================================================
// LARGE COLLECTION CARD
// =====================================================

class _LargeCollectionCard extends StatelessWidget {
  final String image;
  final String smallText;
  final String title;
  final double titleSize;
  final double height;

  const _LargeCollectionCard({
    required this.image,
    required this.smallText,
    required this.title,
    required this.titleSize,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final s = Responsive.scale(context);

    return SizedBox(
      width: double.infinity,
      height: height * s,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12 * s),
        child: Stack(
          children: [

            // BACKGROUND
            Container(
              color: const Color(0xFFF7F7F9),
            ),

            // IMAGE
            Positioned.fill(
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),

            // SMALL TEXT
            Positioned(
              left: 25 * s,
              top: 23 * s,
              child: Text(
                '|  $smallText',
                style: TextStyle(
                  fontSize: Responsive.font(context, 11.5),
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF92929A),
                ),
              ),
            ),

            // TITLE
            Positioned(
              left: 25 * s,
              top: 68 * s,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: Responsive.font(context, titleSize),
                  height: 1.28,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF4E4F5B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// =====================================================
// SMALL COLLECTION CARD
// =====================================================

class _SmallCollectionCard extends StatelessWidget {
  final String image;
  final String category;
  final String title;

  const _SmallCollectionCard({
    required this.image,
    required this.category,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final s = Responsive.scale(context);

    return SizedBox(
      height: 225 * s,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12 * s),
        child: Stack(
          children: [

            // BACKGROUND
            Container(
              color: const Color(0xFFF7F7F9),
            ),

            // IMAGE
            Positioned.fill(
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),

            // CATEGORY
            Positioned(
              left: 95 * s,
              top: 43 * s,
              child: Text(
                category,
                style: TextStyle(
                  fontSize: Responsive.font(context, 13),
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF777780),
                ),
              ),
            ),

            // TITLE
            Positioned(
              left: 95 * s,
              top: 87 * s,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: Responsive.font(context, 17),
                  height: 1.18,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xFF3F4049),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}