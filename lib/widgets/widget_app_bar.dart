import 'package:aseel/constants/colors.dart';
import 'package:aseel/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class WidgetAppBar extends StatelessWidget {
  const WidgetAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: AppColors.accentColor,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      automaticallyImplyLeading: true,
      title: const Text("الأصيل", style: TextStyle(color: Colors.white)),
      actionsIconTheme: const IconThemeData(size: 32),
      actions: [
        Stack(
          children: [
            Center(
              child: IconButton(
                onPressed: () {},
                splashRadius: 24,
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.shopping_cart, size: 24),
              ),
            ),
            Selector<CartProvider, int>(
              selector: (_, cart) => cart.items.length,
              builder: (_, itemCount, __) {
                return Visibility(
                  visible: itemCount > 0,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Colors.green.shade800,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Center(
                      child: Text(
                        itemCount.toString(),
                        style: const TextStyle(color: Colors.white, fontSize: 12, height: 1.5, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
        Center(
          child: IconButton(
            onPressed: () {},
            splashRadius: 24,
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.notifications_none, size: 24),
          ),
        ),
        // const SizedBox(width: 10),
      ],
    );
  }
}
