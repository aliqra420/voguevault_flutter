import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool outlined;
  const AppButton({super.key, required this.label, required this.onPressed, this.outlined = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: outlined
          ? OutlinedButton(onPressed: onPressed, child: Text(label))
          : FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.dark,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
              ),
              onPressed: onPressed,
              child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
            ),
    );
  }
}
