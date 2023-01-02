import 'package:aseel/api_service.dart';
import 'package:aseel/constants/colors.dart';
import 'package:aseel/models/product.dart';
import 'package:aseel/widgets/product_image.dart';
import 'package:flutter/material.dart';

class WidgetHomeProducts extends StatefulWidget {
  final String tagId;
  final String labelName;

  const WidgetHomeProducts({super.key, required this.labelName, required this.tagId});

  @override
  State<WidgetHomeProducts> createState() => _WidgetHomeProductsState();
}

class _WidgetHomeProductsState extends State<WidgetHomeProducts> {
  late APIService apiService;

  @override
  void initState() {
    apiService = APIService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0x0ff4f7fa),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(widget.labelName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: TextButton(
                  onPressed: () {},
                  child: const Text('عرض الكل', style: TextStyle(color: AppColors.accentColor)),
                ),
              ),
            ],
          ),
          _buildProductsNavigation(),
        ],
      ),
    );
  }

  Widget _buildProductsNavigation() {
    return FutureBuilder(
      future: apiService.getProducts(widget.tagId),
      builder: (context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        if (snapshot.hasData) return ProductNavigation(products: snapshot.data!);
        return const Center(child: Text("No Data"));
      },
    );
  }
}

class ProductNavigation extends StatelessWidget {
  final List<Product> products;
  const ProductNavigation({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      alignment: Alignment.centerRight,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          var product = products[index];

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                width: 130,
                height: 130,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [BoxShadow(color: Colors.black12, offset: Offset(0, 5), blurRadius: 6)],
                ),
                child: ProductImage(height: 120, width: 120, imageURL: product.images?[0].url, borderRadius: BorderRadius.circular(10)),
              ),
              Container(
                width: 130,
                alignment: Alignment.centerRight,
                child: Text(product.name, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14, color: Colors.black)),
              ),

              //
              HomeProductPrice(product: product),
            ],
          );
        },
      ),
    );
  }
}

class HomeProductPrice extends StatelessWidget {
  const HomeProductPrice({super.key, required this.product});

  final Product product;

  bool _notNullAndNotEmpty(String? value) {
    if (value == null) return false;

    if (value.isEmpty) return false;

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final price = _notNullAndNotEmpty(product.regularPrice) ? product.regularPrice : product.price;

    return Container(
      margin: const EdgeInsets.all(4),
      width: 130,
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: !_notNullAndNotEmpty(product.regularPrice),
            child: Text(
              "${product.price} QA",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Visibility(
            visible: product.regularPrice != product.salePrice,
            child: Text(
              "${product.regularPrice} QA",
              style: const TextStyle(
                fontSize: 14,
                decoration: TextDecoration.lineThrough,
                color: AppColors.accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Visibility(
            visible: product.regularPrice != product.salePrice,
            child: Text(
              "${product.salePrice} QA",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
