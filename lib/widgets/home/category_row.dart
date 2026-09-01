import 'package:flutter/material.dart';
// removed google_fonts - using default TextStyle

import '../../core/utils/responsive.dart';
import '../../core/constants/app_assets.dart';

class CategoryRow extends StatelessWidget {
  const CategoryRow({super.key});

  @override
  Widget build(BuildContext context) {
    final s = Responsive.scale(context);

    final categories = [
      const _CategoryData(
        icon: Icons.female,
        title: 'Women',
        selected: true,
      ),
      const _CategoryData(
        icon: Icons.male,
        title: 'Men',
        image: AppAssets.menLogo,
      ),
      const _CategoryData(
        icon: Icons.remove_red_eye_outlined,
        title: 'Accessories',
        image: AppAssets.accessoriesLogo,
      ),
      const _CategoryData(
        icon: Icons.spa_outlined,
        title: 'Beauty',
        image: AppAssets.beautyLogo,
      ),
    ];

    final screenWidth = MediaQuery.sizeOf(context).width;

    // compute content width and set symmetric horizontal padding so
    // the list centers when its content is narrower than the screen
    final itemWidth = 60 * s;
    final separatorWidth = 25 * s;
    final totalContentWidth = (itemWidth * categories.length) + (separatorWidth * (categories.length - 1));
    final computedPadding = ((screenWidth - totalContentWidth) / 2).clamp(12 * s, double.infinity);

    return SizedBox(
      height: 91 * s,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: computedPadding,
        ),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        separatorBuilder: (_, __) {
          return SizedBox(width: 25 * s);
        },
        itemBuilder: (context, index) {
          final item = categories[index];

          return SizedBox(
            width: 60 * s,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // CIRCLE
                Container(
                  width: 48 * s,
                  height: 48 * s,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: item.selected
                        ? const Color(0xFF302A29)
                        : const Color(0xFFF5F5F6),
                    border: item.selected
                        ? Border.all(
                            color: const Color(0xFF302A29),
                            width: 2.5 * s,
                          )
                        : null,
                  ),
                  child: Container(
                    margin: item.selected
                        ? EdgeInsets.all(3 * s)
                        : EdgeInsets.zero,
                    decoration: item.selected
                        ? BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 1 * s,
                            ),
                          )
                        : null,
                    child: item.image != null
                        ? Padding(
                            padding: EdgeInsets.all(6 * s),
                            child: Image.asset(
                              item.image!,
                              width: 24 * s,
                              height: 24 * s,
                              fit: BoxFit.contain,
                            ),
                          )
                        : Icon(
                            item.icon,
                            size: 24 * s,
                            color: item.selected ? Colors.white : const Color(0xFFB7B7BB),
                          ),
                  ),
                ),

                SizedBox(height: 7 * s),

                // TITLE
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: Responsive.font(context, 10.5),
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF99999F),
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

class _CategoryData {
  final IconData icon;
  final String title;
  final bool selected;
  final String? image;

  const _CategoryData({
    required this.icon,
    required this.title,
    this.selected = false,
    this.image,
  });
}