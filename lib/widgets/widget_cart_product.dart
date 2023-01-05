import 'package:aseel/models/cart_model.dart';
import 'package:aseel/providers/cart_provider.dart';
import 'package:aseel/providers/loader_provider.dart';
import 'package:aseel/utils/custom_stepper.dart';
import 'package:aseel/widgets/product_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetCartProduct extends StatefulWidget {
  final CartItemModel cartItem;

  const WidgetCartProduct({super.key, required this.cartItem});

  @override
  State<WidgetCartProduct> createState() => _WidgetCartProductState();
}

class _WidgetCartProductState extends State<WidgetCartProduct> {
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
            Row(children: [
              Text(
                "${cartItem.quantity}",
                style: const TextStyle(color: Colors.black),
              ),
              const Text(" x ", style: TextStyle(color: Colors.black)),
              Text(
                "${cartItem.price / 100} ريال = ${cartItem.quantity / 100 * cartItem.price} ريال",
                textDirection: TextDirection.rtl,
                style: const TextStyle(color: Colors.black),
              ),
              // Text(
              //   "${cartItem.quantity} x ${cartItem.price / 100} ريال = ${cartItem.quantity / 100 * cartItem.price} ريال",
              //   textDirection: TextDirection.rtl,
              //   style: const TextStyle(color: Colors.black),
              // ),
              // Text(
              //   "${cartItem.quantity} x ${cartItem.price / 100} ريال = ${cartItem.quantity / 100 * cartItem.price} ريال",
              //   textDirection: TextDirection.rtl,
              //   style: const TextStyle(color: Colors.black),
              // ),
            ]),
          ],
        ),
      ),
      trailing: ItemQuantityController(cartItem: cartItem),
    );
  }
}

class ItemQuantityController extends StatelessWidget {
  final CartItemModel cartItem;
  const ItemQuantityController({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: CustomStepper(
        quantity: cartItem.quantity,
        iconSize: 18,
        lowerLimit: 1,
        upperLimit: 20,
        stepValue: 1,
        onChanged: (value) {
          Provider.of<LoaderProvider>(context, listen: false).setStatus(true);
          var cartProvider = Provider.of<CartProvider>(context, listen: false);
          cartProvider.updateQuantity(cartItem.id, value, onCallback: () {
            Provider.of<LoaderProvider>(context, listen: false).setStatus(false);
          });
        },
        onRemove: () {
          Provider.of<LoaderProvider>(context, listen: false).setStatus(true);
          var cartProvider = Provider.of<CartProvider>(context, listen: false);

          cartProvider.removeFromCart(cartItem.id, onCallback: () {
            Provider.of<LoaderProvider>(context, listen: false).setStatus(false);
          });
        },
      ),
    );
  }
}
