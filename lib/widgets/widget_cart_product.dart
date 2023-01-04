import 'package:aseel/constants/colors.dart';
import 'package:aseel/models/cart_model.dart';
import 'package:aseel/utils/custom_stepper.dart';
import 'package:aseel/widgets/product_image.dart';
import 'package:flutter/material.dart';

class CartProduct extends StatefulWidget {
  final CartItemModel cartItem;
  const CartProduct({super.key, required this.cartItem});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: makeLisTile(context, cartItem: widget.cartItem),
      ),
    );
  }

  ListTile makeLisTile(BuildContext context, {CartItemModel? cartItem}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: SizedBox(
        width: 50,
        height: 50,
        child: ProductImage(width: 70, height: 70, imageURL: cartItem!.thumbnail),
      ),
      title: Padding(padding: const EdgeInsets.all(5), child: Text(cartItem.name)),
      subtitle: Padding(
        padding: const EdgeInsets.all(5),
        child: Wrap(
          direction: Axis.vertical,
          children: [
            Text("${cartItem.price / 100} ريال", style: const TextStyle(color: Colors.black)),
            MaterialButton(
              shape: const CircleBorder(),
              color: AppColors.accentColor,
              child: const Icon(Icons.delete, color: Colors.white, size: 18),
              onPressed: () {},
            ),
          ],
        ),
      ),
      trailing: SizedBox(
        width: 110,
        child: CustomStepper(
          quantity: 1,
          iconSize: 18,
          lowerLimit: 1,
          upperLimit: 20,
          stepValue: 1,
          onChanged: (value) {},
        ),
      ),
    );
  }
}
