import 'package:aseel/api_service.dart';
import 'package:aseel/constants/colors.dart';
import 'package:aseel/models/product_model.dart';
import 'package:aseel/widgets/product_image.dart';
import 'package:aseel/widgets/widget_section_head.dart';
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
          WidgetSectionHead(headLabel: widget.labelName),
          _buildProductsNavigation(),
        ],
      ),
    );
  }

  Widget _buildProductsNavigation() {
    return FutureBuilder(
      future: apiService.getProducts(tagName: widget.tagId),
      builder: (context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return ProductNavigation(products: snapshot.data!);
        }
        return const Center(child: Text("No Data"));
      },
    );
  }
}

class ProductNavigation extends StatelessWidget {
  final List<ProductModel> products;

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
              ProductPrice(product: product),
            ],
          );
        },
      ),
    );
  }
}

class ProductPrice extends StatelessWidget {
  const ProductPrice({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    var sale = double.tryParse(product.salePrice.toString()) ?? 0.0;
    var regular = double.tryParse(product.regularPrice.toString()) ?? double.tryParse(product.price.toString()) ?? 0.0;
    bool productHasSale = regular > sale && sale != 0.0;

    return Visibility(
      visible: sale > 0 || regular > 0,
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // regular
            Text(
              "$regular  ريال",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                decoration: productHasSale ? TextDecoration.lineThrough : null,
                fontWeight: FontWeight.bold,
              ),
            ),
            Visibility(visible: productHasSale, child: const SizedBox(width: 4)),
            // sale
            Visibility(
              visible: productHasSale,
              child: Text(
                "${product.salePrice} QA",
                style: const TextStyle(fontSize: 14, color: AppColors.accentColor, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
