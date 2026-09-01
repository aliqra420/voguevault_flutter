import 'package:flutter/material.dart';
// removed google_fonts - using default TextStyle

import '../../core/utils/responsive.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final s = Responsive.scale(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        37 * s,
        0,
        37 * s,
        16 * s,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Text(
            title,
            style: TextStyle(
              fontSize: Responsive.font(context, 21),
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
              color: Colors.black,
            ),
          ),

          const Spacer(),

          Text(
            'Show all',
            style: TextStyle(
              fontSize: Responsive.font(context, 13.5),
              fontWeight: FontWeight.w400,
              color: const Color(0xFF9B9B9F),
            ),
          ),
        ],
      ),
    );
  }
}
