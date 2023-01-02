import 'package:aseel/config.dart';
import 'package:aseel/widgets/widget_home_category.dart';
import 'package:aseel/widgets/widget_home_products.dart';
import 'package:flutter/material.dart';
import 'package:lecle_flutter_carousel_pro/lecle_flutter_carousel_pro.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            imageCarousal(context),
            const WidgetHomeCategories(),
            const WidgetHomeProducts(labelName: "العروض", tagId: Config.offersTag),
            const WidgetHomeProducts(labelName: "أحدث المنتجات", tagId: Config.newArrivalTag),
            const WidgetHomeProducts(labelName: "الأكثر مبيعاً", tagId: Config.topSellTag),
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
            child: Image.network(
                "https://1.bp.blogspot.com/-lOX1xTwUc34/YQaYqmlWaXI/AAAAAAAAbyI/Vt1FHCoqLdYUNmVw4Ouj3GIRR_vKMHTqgCLcBGAsYHQ/s1890/mobile%2Bshop%2Bflex%2Bbanner%2Bpsd.PNG"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.network("https://1.bp.blogspot.com/-ygGpQHW9Nwk/Uzum2OhAP1I/AAAAAAAAAFA/v7yXN7Hp74Y/s1600/banner+desing.jpg"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.network(
                "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/mobile-phone-shop-sales-banner-design-template-3bb2e0f292a980aadb431b6d0e833652_screen.jpg?ts=1605502688"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUC6vDgKRbyON0FB6y6NfR9PX8baPLu789rrPSgLtElQp40p8WrjzBk06yR-Hemq4hb3o&usqp=CAU"),
          ),
        ],
      ),
    );
  }
}
