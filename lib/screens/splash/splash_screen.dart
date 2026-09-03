import 'dart:async';

import 'package:flutter/material.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 5500));
    _controller.forward();

    _timer = Timer(const Duration(milliseconds: 5500), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0D0D10), Color(0xFF2B1C25)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFD8B3A9)),
                ),
                child: const Center(
                  child: Text(
                    'V',
                    style: TextStyle(
                      fontFamily: 'serif',
                      fontSize: 52,
                      color: Color(0xFFD8B3A9),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'VOGUE\nVAULT',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  height: .9,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'FASHION MEETS YOU',
                style: TextStyle(
                  color: Color(0xFFD8B3A9),
                  letterSpacing: 2.4,
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 50),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return SizedBox(
                    width: 42,
                    height: 42,
                    child: CircularProgressIndicator(
                      value: _controller.value,
                      strokeWidth: 3.5,
                      backgroundColor: Colors.white24,
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFD8B3A9)),
                    ),
                  );
                },
              ),
              const SizedBox(height: 14),
              const Text('Loading...', style: TextStyle(color: Colors.white60, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
