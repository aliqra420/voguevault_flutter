import 'package:flutter/material.dart';
// removed google_fonts - using default TextStyle

import '../../core/constants/app_assets.dart';
import '../../core/utils/responsive.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final s = Responsive.scale(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 37 * s,
      ),
      child: AspectRatio(
        aspectRatio: 1.92,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16 * s),
          child: Stack(
            fit: StackFit.expand,
            children: [

              // IMAGE
              Image.asset(
                AppAssets.heroAutumn,
                fit: BoxFit.cover,
              ),

              // DARK OVERLAY
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.transparent,
                      // 10% black overlay
                      const Color(0x1A000000),
                    ],
                  ),
                ),
              ),

              // TEXT
              Positioned(
                right: 20 * s,
                top: 24 * s,
                child: Text(
                  'Autumn\nCollection\n2021',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: Responsive.font(context, 24),
                    height: 1.18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),

              // DOTS
              Positioned(
                bottom: 10 * s,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _Dot(size: 6 * s),
                    SizedBox(width: 8 * s),
                    _Dot(size: 6 * s, active: true),
                    SizedBox(width: 8 * s),
                    _Dot(size: 6 * s),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final double size;
  final bool active;

  const _Dot({
    required this.size,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: active
            ? Border.all(
                color: Colors.white,
                width: 1,
              )
            : null,
      ),
    );
  }
}