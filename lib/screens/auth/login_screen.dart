import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/app_button.dart';
import '../home/home_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(body: SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.fromLTRB(28, 42, 28, 30), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('Welcome\nBack!', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, height: 1.05)), const SizedBox(height: 12), const Text('Sign in to continue shopping with VogueVault.', style: TextStyle(color: AppColors.muted)), const SizedBox(height: 34),
    TextField(decoration: const InputDecoration(hintText: 'Email address')), const SizedBox(height: 12), TextField(obscureText: true, decoration: const InputDecoration(hintText: 'Password')), const SizedBox(height: 10),
    Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () {}, child: const Text('Forgot password?', style: TextStyle(color: AppColors.coral)))), const SizedBox(height: 8),
    AppButton(label: 'LOGIN', onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()))), const SizedBox(height: 22),
    Row(children: [const Expanded(child: Divider()), Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Text('or', style: TextStyle(color: AppColors.muted))), const Expanded(child: Divider())]), const SizedBox(height: 20),
    AppButton(label: 'Continue with Google', outlined: true, onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()))), const SizedBox(height: 24),
    Center(child: TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupScreen())), child: const Text('Don’t have an account? Sign Up', style: TextStyle(color: AppColors.coral)))),
  ]))));
}
