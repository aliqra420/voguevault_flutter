import 'package:flutter/material.dart';
// import '../../core/theme/app_theme.dart'; // unused
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OnboardingScreen()),
        ),
        child: Container(
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
                const SizedBox(height: 90),
                const Text('Tap to get started', style: TextStyle(color: Colors.white60, fontSize: 12)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
