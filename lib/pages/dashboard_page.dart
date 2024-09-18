import 'package:aseel/providers/home_provider.dart';
import 'package:aseel/widgets/widget_home_category.dart';
import 'package:aseel/widgets/widget_home_products.dart';
import 'package:flutter/material.dart';
import 'package:lecle_flutter_carousel_pro/lecle_flutter_carousel_pro.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            imageCarousal(context),
            const WidgetHomeCategories(),
            WidgetHomeProducts(
              labelName: "العروض",
              products: Provider.of<HomeProvider>(context).offers,
            ),
            WidgetHomeProducts(
              labelName: "أحدث المنتجات",
              products: Provider.of<HomeProvider>(context).newArrival,
            ),
            WidgetHomeProducts(
              labelName: "الأكثر مبيعاً",
              products: Provider.of<HomeProvider>(context).topSelling,
            ),
          ],
        ),
      ),
    );
  }

  Widget imageCarousal(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 320,
      child: Carousel(
        overlayShadow: true,
        hasBorderRadius: true,
        dotBgColor: Colors.transparent,
        boxFit: BoxFit.none,
        autoplay: true,
        dotSize: 4.0,
        autoplayDuration: const Duration(seconds: 3),
        images: [
          FittedBox(
            fit: BoxFit.fill,
            child: Image.network("http://192.168.18.39:8080/wp-content/uploads/2024/09/beanie-2.jpg"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.network("http://192.168.18.39:8080/wp-content/uploads/2024/09/beanie-2.jpg"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.network("http://192.168.18.39:8080/wp-content/uploads/2024/09/beanie-2.jpg"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.network("http://192.168.18.39:8080/wp-content/uploads/2024/09/beanie-2.jpg"),
          ),
        ],
      ),
    );
  }
}
