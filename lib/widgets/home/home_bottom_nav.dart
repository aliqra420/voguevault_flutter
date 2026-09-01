import 'package:flutter/material.dart';

import '../../core/utils/responsive.dart';

class HomeBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const HomeBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final s = Responsive.scale(context);

    final icons = [
      Icons.home_outlined,
      Icons.search_rounded,
      Icons.shopping_bag_outlined,
      Icons.person_outline_rounded,
    ];

    return Container(
      height: 72 * s,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24 * s),
          topRight: Radius.circular(24 * s),
        ),
        border: Border.all(
          color: const Color(0xFFECECEF),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround,
          children: List.generate(
            icons.length,
            (index) {
              final selected =
                  selectedIndex == index;

              return GestureDetector(
                onTap: () => onChanged(index),
                behavior: HitTestBehavior.opaque,
                child: SizedBox(
                  width: 58 * s,
                  height: 60 * s,
                  child: Center(
                    child: Icon(
                      icons[index],
                      size: 29 * s,
                      color: selected
                          ? const Color(0xFF111111)
                          : const Color(0xFFDDE0E5),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}