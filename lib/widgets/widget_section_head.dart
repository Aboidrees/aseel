import 'package:aseel/constants/colors.dart';
import 'package:flutter/material.dart';

class WidgetSectionHead extends StatelessWidget {
  const WidgetSectionHead({super.key, required this.headLabel});

  final String headLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(headLabel, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: TextButton(
            onPressed: () {},
            child: const Text('عرض الكل', style: TextStyle(color: AppColors.accentColor)),
          ),
        ),
      ],
    );
  }
}
