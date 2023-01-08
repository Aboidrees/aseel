import 'package:aseel/constants/colors.dart';
import 'package:flutter/material.dart';

class WidgetSectionHead extends StatelessWidget {
  const WidgetSectionHead({super.key, required this.headLabel, this.onPressed});

  final String headLabel;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(headLabel, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: TextButton(
            onPressed: onPressed,
            child: const Text('عرض الكل', style: TextStyle(color: AppColors.accentColor)),
          ),
        ),
      ],
    );
  }
}
