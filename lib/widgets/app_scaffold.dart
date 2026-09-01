import 'package:flutter/material.dart';
import '../core/utils/responsive.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final bool scroll;
  const AppScaffold({super.key, required this.body, this.bottomNavigationBar, this.scroll = false});

  @override
  Widget build(BuildContext context) {
    final content = scroll ? SingleChildScrollView(padding: Responsive.pagePadding(context), child: body) : body;
    return Scaffold(body: SafeArea(child: content), bottomNavigationBar: bottomNavigationBar);
  }
}
