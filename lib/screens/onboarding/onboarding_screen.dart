import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int index = 0;

  final pages = [
    {
      'title': 'Choose Products',
      'subtitle': 'Find your favourite fashion pieces and build your own look.',
      'image': 'assets/images/hero_autumn.png',
    },
    {
      'title': 'Make Payment',
      'subtitle': 'Simple and secure checkout for a smooth shopping experience.',
      'image': 'assets/images/cotton.png',
    },
    {
      'title': 'Get Your Order',
      'subtitle': 'Track your purchase and receive your order with confidence.',
      'image': 'assets/images/elegant.png',
    },
  ];

  void next() {
    if (index < pages.length - 1) {
      setState(() => index++);
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = pages[index];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 28, 24),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
                  child: const Text('Skip', style: TextStyle(color: AppColors.coral)),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        p['image']!,
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 38),
                    Text(p['title']!, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 12),
                    Text(p['subtitle']!, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.muted, fontSize: 13, height: 1.5)),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: i == index ? 24 : 6,
                    height: 5,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(color: i == index ? AppColors.coral : AppColors.line, borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: next,
                  child: Text(index == pages.length - 1 ? 'Get Started' : 'Next', style: const TextStyle(color: AppColors.coral, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
