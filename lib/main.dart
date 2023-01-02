import 'package:aseel/pages/home_page.dart';
import 'package:aseel/utils/create_swatch_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: GoogleFonts.cairo().fontFamily,
        primaryColor: Colors.white,
        primarySwatch: createMaterialColor(Colors.amberAccent),
        colorScheme: ColorScheme.fromSwatch(),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(elevation: 0, foregroundColor: Colors.white),
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 22.0, color: Colors.amberAccent),
          headline2: TextStyle(fontSize: 24.0, color: Colors.amberAccent, fontWeight: FontWeight.w700),
          bodyText1: TextStyle(fontSize: 14.0, color: Colors.blueAccent, fontWeight: FontWeight.w400),
        ),
      ),
      home: const Directionality(textDirection: TextDirection.rtl, child: HomePage()),
    );
  }
}
