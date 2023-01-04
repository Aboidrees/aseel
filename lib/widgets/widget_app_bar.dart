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
        Center(child: IconButton(onPressed: () {}, splashRadius: 24, padding: EdgeInsets.zero, icon: const Icon(Icons.notifications_none))),
        const SizedBox(width: 10),
        Stack(
          children: [
            Center(child: IconButton(onPressed: () {}, splashRadius: 24, padding: EdgeInsets.zero, icon: const Icon(Icons.shopping_cart))),
            Visibility(
              visible: Provider.of<CartProvider>(context).cartDetails?.items?.isNotEmpty ?? false,
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(color: Colors.green.shade800, borderRadius: BorderRadius.circular(9)),
                child: Center(
                  child: Text(
                    Provider.of<CartProvider>(context).cartDetails?.items?.length.toString() ?? "",
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
