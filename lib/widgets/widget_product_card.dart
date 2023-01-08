// import 'package:aseel/models/product_model.dart';
// import 'package:aseel/pages/product_details_page.dart';
// import 'package:aseel/providers/loader_provider.dart';
// import 'package:aseel/providers/product_provider.dart';
// import 'package:aseel/widgets/image_display.dart';
// import 'package:aseel/widgets/widget_home_products.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

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
