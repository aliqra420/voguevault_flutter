import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const VogueVaultApp());
}

class VogueVaultApp extends StatelessWidget {
  const VogueVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VogueVault',
      theme: AppTheme.light,
      home: const SplashScreen(),
    );
  }
}
