import 'package:aseel/constants/colors.dart';
import 'package:aseel/pages/dashboard_page.dart';
import 'package:aseel/utils/cart_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _widgetList = <Widget>[
    const DashboardPage(),
    const DashboardPage(),
    const DashboardPage(),
    const DashboardPage(),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarBuilder(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.accentColor,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.shifting,
        currentIndex: _index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CartIcons.home),
            label: "Store",
          ),
          BottomNavigationBarItem(
            icon: Icon(CartIcons.cart),
            label: "My Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(CartIcons.favorites),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            icon: Icon(CartIcons.account),
            label: "Account",
          ),
        ],
        onTap: (value) => setState(() => _index = value),
      ),
      body: _widgetList[_index],
    );
  }

  _appBarBuilder() {
    return AppBar(
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: AppColors.accentColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: const Text("Al Aseel", style: TextStyle(color: Colors.white)),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, color: Colors.white)),
        const SizedBox(width: 10),
        IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart, color: Colors.white)),
      ],
    );
  }
}
