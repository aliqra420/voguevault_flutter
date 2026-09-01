import 'package:flutter/material.dart';
import '../../widgets/app_button.dart';
import '../home/home_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create an\nAccount',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 30),
              TextField(decoration: const InputDecoration(hintText: 'Full name')),
              const SizedBox(height: 12),
              TextField(decoration: const InputDecoration(hintText: 'Email address')),
              const SizedBox(height: 12),
              TextField(obscureText: true, decoration: const InputDecoration(hintText: 'Password')),
              const SizedBox(height: 12),
              TextField(obscureText: true, decoration: const InputDecoration(hintText: 'Confirm password')),
              const SizedBox(height: 24),
              AppButton(
                label: 'CREATE ACCOUNT',
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                  (_) => false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
