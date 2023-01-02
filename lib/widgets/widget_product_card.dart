import 'package:aseel/constants/colors.dart';
import 'package:aseel/models/product.dart';
import 'package:aseel/widgets/product_image.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Color(0xFFF8F8F8), blurRadius: 15, spreadRadius: 10)],
      ),
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: ProductImage(
                    width: 110,
                    height: 110,
                    imageURL: product.images?[0].url,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Visibility(
                  visible: product.calculateDiscount() > 0,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        'خصم ${product.calculateDiscount()}%',
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              product.name,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: product.regularPrice != product.salePrice,
                  child: Text(
                    "${product.regularPrice} QA",
                    style: const TextStyle(fontSize: 14, decoration: TextDecoration.lineThrough, color: AppColors.accentColor, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  "${product.regularPrice} QA",
                  style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
