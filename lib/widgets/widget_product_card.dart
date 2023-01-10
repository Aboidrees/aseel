// import 'package:aseel/models/product_model.dart';
// import 'package:aseel/pages/product_details_page.dart';
// import 'package:aseel/providers/loader_provider.dart';
// import 'package:aseel/providers/product_provider.dart';
// import 'package:aseel/widgets/image_display.dart';
// import 'package:aseel/widgets/widget_home_products.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import 'package:aseel/constants/colors.dart';
import 'package:aseel/models/product_model.dart';
import 'package:aseel/providers/product_provider.dart';
import 'package:aseel/utils/enums.dart';
import 'package:aseel/widgets/image_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/product_details_page.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.backgroundColor = Colors.white,
    this.width = 130,
    this.height = 115,
    this.cornerRadius = 0,
    this.imageMargin = 0,
    this.margin = 2,
    this.boxShadow,
  });

  final ProductModel product;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final double? cornerRadius;
  final double? imageMargin;
  final double? margin;

  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ProductProvider>()
          ..setCurrentProduct(product)
          ..setLoadingVariationsStatus(LoadingStatus.initial)
          ..getProductVariations();
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductDetailsPage()));
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(cornerRadius!),
          boxShadow: boxShadow,
        ),
        margin: EdgeInsets.all(margin!),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: width,
              height: height,
              margin: EdgeInsets.all(imageMargin!),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(cornerRadius!),
                boxShadow: const [BoxShadow(color: Colors.black12, offset: Offset(1, 2), blurRadius: 5)],
              ),
              child: ImageDisplay(imageURL: product.images?[0].url, borderRadius: BorderRadius.circular(cornerRadius!)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(product.name, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11)),
            ),

            //
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ProductPrice(product: product),
            ),
          ],
        ),
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
    var style = const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold);

    return Visibility(
      visible: sale > 0 || regular > 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // regular
          Text("$regular ريال", style: style.copyWith(decoration: productHasSale ? TextDecoration.lineThrough : null)),
          Visibility(visible: productHasSale, child: const SizedBox(width: 4)),
          // sale
          Visibility(
            visible: productHasSale,
            child: Text("${product.salePrice} ريال", style: style.copyWith(color: AppColors.accentColor)),
          ),
        ],
      ),
    );
  }
}

// class ProductCard extends StatelessWidget {
//   final ProductModel product;

//   const ProductCard({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     var productProvider = Provider.of<ProductProvider>(context);

//     return GestureDetector(
//       // TODO: save the current product in the provider.

//       onTap: () {
//         context.read<LoaderProvider>().setStatus(true);

//         productProvider.setCurrentProduct(
//           product,
//           onCallback: context.read<LoaderProvider>().setStatus(false),
//         );
//         Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductDetailsPage()));
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: const [BoxShadow(color: Color(0xFFF8F8F8), blurRadius: 15, spreadRadius: 10)],
//         ),
//         margin: const EdgeInsets.all(10),
//         // padding: const EdgeInsets.all(10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Stack(
//               children: [
//                 ImageDisplay(imageURL: product.images?[0].url, borderRadius: BorderRadius.circular(20)),
//                 Visibility(
//                   visible: product.calculateDiscount() > 0,
//                   child: Align(
//                     alignment: Alignment.topRight,
//                     child: Container(
//                       margin: const EdgeInsets.all(10),
//                       padding: const EdgeInsets.all(5),
//                       decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(50)),
//                       child: Text(
//                         'خصم ${product.calculateDiscount()}%',
//                         style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   left: 5,
//                   bottom: 5,
//                   child: Container(
//                     decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(20)),
//                     child: ProductPrice(product: product),
//                   ),
//                 ),
//               ],
//             ),
//             Expanded(
//               child: Container(
//                 alignment: Alignment.center,
//                 width: double.infinity,
//                 height: 50,
//                 padding: const EdgeInsets.all(5),
//                 child: Text(product.name, maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
