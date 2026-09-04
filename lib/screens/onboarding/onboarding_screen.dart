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
      'title': 'Discover Your Style',
      'subtitle': 'Explore the latest trends and timeless fashion.',
      'image': 'assets/images/onboarding1.png',
    },
    {
      'title': 'Quality You Love',
      'subtitle': 'Premium Quality products, curated for you.',
      'image': 'assets/images/onboarding2.png',
    },
    {
      'title': 'Shop with Ease',
      'subtitle': 'A seamless shopping experience anytime, anywhere.',
      'image': 'assets/images/onboarding3.png',
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
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.42,
                        maxWidth: MediaQuery.of(context).size.width,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          p['image']!,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
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
