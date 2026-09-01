import 'package:flutter/material.dart';
// removed google_fonts - using default TextStyle

import '../../core/constants/app_assets.dart';
import '../../core/utils/responsive.dart';

class PartyBanner extends StatelessWidget {
  const PartyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final s = Responsive.scale(context);

    return SizedBox(
      height: 180 * s,
      width: double.infinity,
      child: Container(
        color: const Color(0xFFF7F7F9),
        child: Stack(
          children: [

            // WOMAN IMAGE
            Positioned(
              right: -5 * s,
              top: 0,
              bottom: 0,
              width: 190 * s,
              child: Image.asset(
                AppAssets.party,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),

            // TEXT
            Positioned(
              left: 61 * s,
              top: 37 * s,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    '|  NEW COLLECTION',
                    style: TextStyle(
                      fontSize: Responsive.font(context, 11),
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.2,
                      color: const Color(0xFF9999A1),
                    ),
                  ),

                  SizedBox(height: 25 * s),

                  Text(
                    'HANG OUT\n& PARTY',
                    style: TextStyle(
                      fontSize: Responsive.font(context, 20),
                      height: 1.25,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xFF45454D),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}