import 'package:aseel/constants/colors.dart';
import 'package:aseel/providers/cart_provider.dart';
import 'package:aseel/providers/loader_provider.dart';
import 'package:aseel/utils/progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  BasePageState createState() => BasePageState();
}

class BasePageState<T extends BasePage> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoaderProvider>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: _appBarBuilder(),
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: ProgressHUD(
              inAsyncCall: controller.isApiCallProcess,
              opacity: 0.3,
              child: pageUI(),
            ),
          ),
        );
      },
    );
  }

  Widget pageUI() {
    return Container();
  }

  _appBarBuilder() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: AppColors.accentColor,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      automaticallyImplyLeading: true,
      title: const Text("Al Aseel", style: TextStyle(color: Colors.white)),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, size: 32)),
        const SizedBox(width: 10),
        Stack(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart, size: 32)),
            Visibility(
              visible: Provider.of<CartProvider>(context, listen: false).cartDetails?.items?.isNotEmpty ?? false,
              child: Positioned(
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(color: Colors.green.shade800, borderRadius: BorderRadius.circular(25)),
                  child: Center(
                    child: Text(
                      Provider.of<CartProvider>(context, listen: false).cartDetails?.items?.length.toString() ?? "",
                      style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
