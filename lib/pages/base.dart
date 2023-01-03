import 'package:aseel/providers/loader_provider.dart';
import 'package:aseel/utils/progress_hud.dart';
import 'package:aseel/widgets/widget_app_bar.dart';
import 'package:flutter/material.dart';
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
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(58),
              child: WidgetAppBar(context: context),
            ),
            body: ProgressHUD(
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
}
