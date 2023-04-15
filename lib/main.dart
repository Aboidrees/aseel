import 'package:aseel/pages/base.dart';
import 'package:aseel/pages/cart_page.dart';
import 'package:aseel/pages/dashboard_page.dart';
import 'package:aseel/pages/home_page.dart';
import 'package:aseel/pages/product_details_page.dart';
import 'package:aseel/pages/products_menu_page.dart';
import 'package:aseel/providers/cart_provider.dart';
import 'package:aseel/providers/home_provider.dart';
import 'package:aseel/providers/loader_provider.dart';
import 'package:aseel/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider(), child: const DashboardPage()),
        ChangeNotifierProvider(create: (context) => ProductProvider(), child: const ProductsMenuPage()),
        ChangeNotifierProvider(create: (context) => CartProvider(), child: const ProductDetailsPage()),
        ChangeNotifierProvider(create: (context) => CartProvider(), child: const CartPage()),
        ChangeNotifierProvider(create: (context) => LoaderProvider(), child: const BasePage()),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'الأصيل',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.cairo().fontFamily,
        primaryColor: Colors.white,
        primarySwatch: Colors.amber,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(elevation: 0, foregroundColor: Colors.white),
        textTheme: const TextTheme(
          // Short Text, high-emphasis
          headlineLarge: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontSize: 12.0, color: Colors.black, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontSize: 10.0, color: Colors.black, fontWeight: FontWeight.bold),

          // Short Text, medium-emphasis
          titleLarge: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w400),
          titleMedium: TextStyle(fontSize: 12.0, color: Colors.black, fontWeight: FontWeight.w400),
          titleSmall: TextStyle(fontSize: 10.0, color: Colors.black, fontWeight: FontWeight.w400),

          // Short important text, numarical
          displayLarge: TextStyle(fontSize: 14.0, color: Colors.amber, fontWeight: FontWeight.w400),
          displayMedium: TextStyle(fontSize: 12.0, color: Colors.amber, fontWeight: FontWeight.w400),
          displaySmall: TextStyle(fontSize: 10.0, color: Colors.amber, fontWeight: FontWeight.w400),

          // long texrt
          bodyLarge: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w400),
          bodyMedium: TextStyle(fontSize: 12.0, color: Colors.black, fontWeight: FontWeight.w400),
          bodySmall: TextStyle(fontSize: 10.0, color: Colors.black, fontWeight: FontWeight.w400),
        ),
      ),
      home: const HomePage(),
    );
  }
}
