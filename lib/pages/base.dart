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
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        child: pageUI(),
      ),
    );
  }

  Widget pageUI() {
    return Container();
  }

  _appBarBuilder() {
    return AppBar(
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: AppColors.accentColor,
      elevation: 0,
      automaticallyImplyLeading: true,
      title: const Text("Al Aseel", style: TextStyle(color: Colors.white)),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, color: Colors.white)),
        const SizedBox(width: 10),
        IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart, color: Colors.white)),
      ],
    );
  }
}
