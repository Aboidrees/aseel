import 'package:aseel/pages/home_page.dart';
import 'package:aseel/pages/products_menu_page.dart';
import 'package:aseel/providers/provider_product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
          child: const ProductsMenuPage(),
        )
      ],
      child: MaterialApp(
        title: 'الأصيل',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.cairo().fontFamily,
          primaryColor: Colors.white,
          primarySwatch: Colors.amber,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(elevation: 0, foregroundColor: Colors.white),
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 22.0, color: Colors.amber, fontWeight: FontWeight.w400),
            headline2: TextStyle(fontSize: 24.0, color: Colors.amber, fontWeight: FontWeight.w700),
            bodyText1: TextStyle(fontSize: 14.0, color: Colors.amber, fontWeight: FontWeight.w400),
          ),
        ),
        home: const Directionality(textDirection: TextDirection.rtl, child: HomePage()),
      ),
    );
  }
}
