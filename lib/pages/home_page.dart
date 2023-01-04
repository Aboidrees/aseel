import 'package:aseel/constants/colors.dart';
import 'package:aseel/pages/cart_page.dart';
import 'package:aseel/pages/dashboard_page.dart';
import 'package:aseel/utils/cart_icons.dart';
import 'package:aseel/widgets/widget_app_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _widgetList = <Widget>[
    const DashboardPage(),
    const CartPage(),
    const DashboardPage(),
    const DashboardPage(),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const PreferredSize(preferredSize: Size.fromHeight(58), child: WidgetAppBar()),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.accentColor,
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.shifting,
          currentIndex: _index,
          items: [
            BottomNavigationBarItem(
              icon: IconButton(onPressed: () => setState(() => _index = 0), icon: const Icon(CartIcons.home)),
              label: "Store",
            ),
            BottomNavigationBarItem(
              icon: IconButton(onPressed: () => setState(() => _index = 1), icon: const Icon(CartIcons.cart)),
              label: "My Cart",
            ),
            BottomNavigationBarItem(
              icon: IconButton(onPressed: () => setState(() => _index = 2), icon: const Icon(CartIcons.favorites)),
              label: "Favorites",
            ),
            BottomNavigationBarItem(
              icon: IconButton(onPressed: () => setState(() => _index = 3), icon: const Icon(CartIcons.account)),
              label: "Account",
            ),
          ],
          onTap: (value) => setState(() => _index = value),
        ),
        body: _widgetList[_index],
      ),
    );
  }
}
