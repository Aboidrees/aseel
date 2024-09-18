import 'package:aseel/pages/products_menu_page.dart';
import 'package:aseel/providers/home_provider.dart';
import 'package:aseel/widgets/image_display.dart';
import 'package:aseel/widgets/widget_section_head.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce_client/woocommerce_client.dart';
import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

class WidgetHomeCategories extends StatelessWidget {
  const WidgetHomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Consumer<HomeProvider>(
        builder: (_, controller, __) {
          return Column(
            children: [
              const WidgetSectionHead(headLabel: "كل التصنيفات"),
              Container(
                height: 150,
                alignment: Alignment.centerRight,
                child: ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) => CategoryListItem(category: controller.categories[index]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CategoryListItem extends StatelessWidget {
  final ProductCat category;
  const CategoryListItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductsMenuPage(categoryId: category.id)),
        );
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(12),
            width: 80,
            height: 80,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(1, 2), blurRadius: 5)],
            ),

            //! Add WIDTH & HIEGHT less than 80 to ImageDisplay to create border for the image
            child: ImageDisplay(imageURL: category.image?.src ?? "", borderRadius: BorderRadius.circular(40)),
          ),
          Text(category.name.toString()),
        ],
      ),
    );
  }
}
