import 'package:aseel/constants/colors.dart';
import 'package:aseel/utils/progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  BasePageState createState() => BasePageState();
}

class BasePageState<T extends BasePage> extends State<T> {
  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarBuilder(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ProgressHUD(
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          child: pageUI(),
        ),
      ),
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
        IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
        const SizedBox(width: 10),
        IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
      ],
    );
  }
}
