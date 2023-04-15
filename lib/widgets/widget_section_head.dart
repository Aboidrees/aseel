import 'package:flutter/material.dart';

class WidgetSectionHead extends StatelessWidget {
  const WidgetSectionHead({super.key, required this.headLabel, this.onPressed});

  final String headLabel;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(headLabel, style: theme.headlineLarge),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: TextButton(
            onPressed: onPressed,
            child: Text('عرض الكل', style: theme.displayMedium),
          ),
        ),
      ],
    );
  }
}
