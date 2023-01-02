import 'package:aseel/api_service.dart';
import 'package:aseel/constants/colors.dart';
import 'package:aseel/models/category.dart' as category_model;
import 'package:aseel/pages/products_menu_page.dart';
import 'package:flutter/material.dart';

class WidgetHomeCategories extends StatefulWidget {
  const WidgetHomeCategories({super.key});

  @override
  State<WidgetHomeCategories> createState() => _WidgetHomeCategoriesState();
}

class _WidgetHomeCategoriesState extends State<WidgetHomeCategories> {
  late APIService apiService;

  @override
  void initState() {
    apiService = APIService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text("كل التصنيفات", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                child: Text("إظهار الكل", style: TextStyle(color: AppColors.accentColor)),
              )
            ],
          ),
          _buildCategoriesNavigation(),
        ],
      ),
    );
  }

  Widget _buildCategoriesNavigation() {
    return FutureBuilder(
      future: apiService.getCategories(),
      builder: (context, AsyncSnapshot<List<category_model.Category>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        if (snapshot.hasData) return CategoryNavigation(categories: snapshot.data!);
        return const Center(child: Text("No Data"));
      },
    );
  }
}

class CategoryNavigation extends StatelessWidget {
  final List<category_model.Category> categories;

  const CategoryNavigation({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      alignment: Alignment.centerRight,
      child: ListView.builder(
        shrinkWrap: true,
        reverse: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          var category = categories[index];

          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsMenuPage(categoryId: category.id))),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  width: 80,
                  height: 80,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0, 5), blurRadius: 5)],
                  ),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: (category.image != null && category.image?.url != null) ? NetworkImage(category.image?.url ?? "") : null,
                  ),
                ),
                Row(
                  children: [
                    Text(category.name.toString()),
                    const Icon(Icons.keyboard_arrow_left, size: 14),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
