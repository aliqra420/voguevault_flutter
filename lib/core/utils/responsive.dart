import 'package:flutter/material.dart';

class Responsive {
  Responsive._();

  static double width(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static double height(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  /// Base design = 390px
  static double scale(BuildContext context) {
    final width = Responsive.width(context);

    return (width / 390).clamp(0.82, 1.15);
  }

  static double size(
    BuildContext context,
    double value,
  ) {
    return value * scale(context);
  }

  static double font(
    BuildContext context,
    double value,
  ) {
    return value * scale(context);
  }

  static EdgeInsets pagePadding(BuildContext context) {
    // Default horizontal padding used across the app
    final horizontal = size(context, 22);
    return EdgeInsets.symmetric(horizontal: horizontal);
  }
}