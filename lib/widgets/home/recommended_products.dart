import 'package:flutter/material.dart';
// removed google_fonts - using default TextStyle

import '../../core/constants/app_assets.dart';
import '../../core/utils/responsive.dart';

class RecommendedProducts extends StatelessWidget {
  const RecommendedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final s = Responsive.scale(context);

    final products = [
      _Recommended(
        image: AppAssets.hoodie,
        name: 'White fashion hoodie',
        price: '\$ 29.00',
      ),
      _Recommended(
        image: AppAssets.cotton,
        name: 'Cotton T-shirt',
        price: '\$ 30.00',
      ),
    ];

    return SizedBox(
      height: 76 * s,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: 37 * s,
        ),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: products.length,
        separatorBuilder: (_, __) {
          return SizedBox(width: 17 * s);
        },
        itemBuilder: (context, index) {
          final product = products[index];

          return Container(
            width: 245 * s,
            height: 76 * s,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9 * s),
              border: Border.all(
                color: const Color(0xFFF0F0F2),
              ),
            ),
            child: Row(
              children: [

                // IMAGE
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(9 * s),
                    bottomLeft: Radius.circular(9 * s),
                  ),
                  child: SizedBox(
                    width: 76 * s,
                    height: 76 * s,
                    child: Image.asset(
                      product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(width: 11 * s),

                // TEXT
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 8 * s,
                    ),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        Text(
                          product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: Responsive.font(context, 12.5),
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF282830),
                          ),
                        ),

                        SizedBox(height: 3 * s),

                        Text(
                          product.price,
                          style: TextStyle(
                            fontSize: Responsive.font(context, 16),
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
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

class _Recommended {
  final String image;
  final String name;
  final String price;

  const _Recommended({
    required this.image,
    required this.name,
    required this.price,
  });
}