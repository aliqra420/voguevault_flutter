import 'package:flutter/material.dart';
// removed google_fonts - using default TextStyle

import '../../core/constants/app_assets.dart';
import '../../core/utils/responsive.dart';

class FeatureProducts extends StatelessWidget {
  const FeatureProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final s = Responsive.scale(context);

    final products = [
      _Product(
        image: AppAssets.productSweater,
        name: 'Turtleneck Sweater',
        price: '\$ 39.99',
      ),
      _Product(
        image: AppAssets.productDress,
        name: 'Long Sleeve Dress',
        price: '\$ 45.00',
      ),
      _Product(
        image: AppAssets.productSport,
        name: 'Sportwear',
        price: '\$ 80.00',
      ),
    ];

    return SizedBox(
      height: 270 * s,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: 39 * s,
        ),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: products.length,
        separatorBuilder: (_, __) {
          return SizedBox(width: 23 * s);
        },
        itemBuilder: (context, index) {
          final product = products[index];

          final cardWidth = 145 * s;

          return SizedBox(
            width: cardWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // PRODUCT IMAGE
                ClipRRect(
                  borderRadius: BorderRadius.circular(11 * s),
                  child: SizedBox(
                    width: cardWidth,
                    height: 197 * s,
                    child: Image.asset(
                      product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: 12 * s),

                // PRODUCT NAME
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: Responsive.font(context, 12.5),
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF222229),
                  ),
                ),

                SizedBox(height: 4 * s),

                // PRICE
                Text(
                  product.price,
                  style: TextStyle(
                    fontSize: Responsive.font(context, 17),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF15151A),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Product {
  final String image;
  final String name;
  final String price;

  const _Product({
    required this.image,
    required this.name,
    required this.price,
  });
}