import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/utils/responsive.dart';
import '../../data/products.dart';
import '../../screens/product/show_all_products_screen.dart';

class MenHeroBanner extends StatefulWidget {
  final String category;

  const MenHeroBanner({super.key, this.category = 'Men'});

  @override
  State<MenHeroBanner> createState() => _MenHeroBannerState();
}

class _MenHeroBannerState extends State<MenHeroBanner> {
  final PageController _controller = PageController();
  late Timer _timer;
  int _page = 0;

  final Random _rnd = Random();
  List<String> _images = [];

  @override
  void initState() {
    super.initState();
    // collect images from products data across Women, Men, Accessories, and Beauty
    final prefixes = ['assets/images/women/', 'assets/images/dress/', 'assets/images/men/', 'assets/images/accessories/', 'assets/images/beauty/'];
    final imagesList = products.where((p) => prefixes.any((pre) => p.image.startsWith(pre))).map((p) => p.image).toSet().toList();
    if (imagesList.isNotEmpty) {
      _images = _sample(imagesList, 6);
    } else {
      _loadAssetsForCategory();
    }

    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted || _images.isEmpty) return;
      _page = (_page + 1) % _images.length;
      _controller.animateToPage(_page, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadAssetsForCategory() async {
    try {
      final manifestContent = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      final prefixes = ['assets/images/women/', 'assets/images/dress/', 'assets/images/men/', 'assets/images/accessories/', 'assets/images/beauty/'];
      final keys = manifestMap.keys.where((k) => prefixes.any((p) => k.startsWith(p))).toList();
      setState(() {
        _images = keys.isNotEmpty ? _sample(keys, 6) : ['assets/images/men/Mens_Denim_Jeans_Apex[Dark].jpg'];
      });
    } catch (_) {
      setState(() {
        _images = ['assets/images/men/Mens_Denim_Jeans_Apex[Dark].jpg'];
      });
    }
  }

  List<String> _sample(List<String> src, int count) {
    final list = src.toSet().toList();
    if (list.length <= count) return list;
    final out = <String>[];
    while (out.length < count) {
      final pick = list[_rnd.nextInt(list.length)];
      if (!out.contains(pick)) out.add(pick);
    }
    return out;
  }

  String _categoryFromPath(String path) {
    final p = path.toLowerCase();
    if (p.contains('/men/')) return 'Men';
    if (p.contains('/dress/') || p.contains('/women/')) return 'Women';
    if (p.contains('/accessories/')) return 'Accessories';
    if (p.contains('/beauty/')) return 'Beauty';
    return widget.category;
  }

  void _openCollection(String path) {
    final category = _categoryFromPath(path);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ShowAllProductsScreen(
          section: 'Top Collection',
          category: category,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = Responsive.scale(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 37 * s),
      child: AspectRatio(
        aspectRatio: 1.92,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16 * s),
          child: Stack(
            fit: StackFit.expand,
            children: [
              PageView.builder(
                controller: _controller,
                itemCount: _images.length,
                itemBuilder: (_, i) => GestureDetector(
                  onTap: () => _openCollection(_images[i]),
                  child: Image.asset(_images[i], fit: BoxFit.cover),
                ),
                onPageChanged: (i) => setState(() => _page = i),
              ),

              IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.transparent, const Color(0x1A000000)],
                    ),
                  ),
                ),
              ),

              Positioned(
                right: 20 * s,
                top: 24 * s,
                child: Builder(builder: (_) {
                  final current = _images.isNotEmpty && _page < _images.length ? _categoryFromPath(_images[_page]) : widget.category;
                  return Text(
                    '$current\nCollection\n2026',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: Responsive.font(context, 24),
                      height: 1.18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  );
                }),
              ),

              Positioned(
                bottom: 10 * s,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: (() {
                    final list = <Widget>[];
                    for (var i = 0; i < _images.length; i++) {
                      list.add(_Dot(size: 6 * s, active: _page == i));
                      if (i != _images.length - 1) list.add(SizedBox(width: 8 * s));
                    }
                    return list;
                  })(),
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

  const _Dot({required this.size, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(active ? 1 : 0.5),
      ),
    );
  }
}
