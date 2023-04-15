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
            WidgetHomeProducts(labelName: "العروض", products: Provider.of<HomeProvider>(context).offers),
            WidgetHomeProducts(labelName: "أحدث المنتجات", products: Provider.of<HomeProvider>(context).newArrival),
            WidgetHomeProducts(labelName: "الأكثر مبيعاً", products: Provider.of<HomeProvider>(context).topSelling),
          ],
        ),
      ),
    );
  }

  Widget imageCarousal(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Carousel(
        overlayShadow: false,
        hasBorderRadius: true,
        boxFit: BoxFit.none,
        autoplay: true,
        dotSize: 4.0,
        images: [
          FittedBox(
            fit: BoxFit.fill,
            child: Image.network("https://upload.wikimedia.org/wikipedia/commons/d/de/Nokota_Horses_cropped.jpg"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Points_of_a_horse.jpg/330px-Points_of_a_horse.jpg"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.network("https://cdn.equishop.com/img/cms/horse-anatomy/muscular-system.jpg"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.network("https://www.horse-genetics.com/images/KholorByDesign-400.jpg"),
          ),
        ],
      ),
    );
  }
}
