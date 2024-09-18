import 'package:aseel/constants/colors.dart';
import 'package:aseel/models/cart_model.dart';
import 'package:aseel/providers/cart_provider.dart';
import 'package:aseel/providers/loader_provider.dart';
import 'package:aseel/utils/custom_stepper.dart';
import 'package:aseel/utils/util.dart';
import 'package:aseel/widgets/image_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce_client/woocommerce_client.dart';
import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

class WidgetCartProduct extends StatefulWidget {
  final ShopOrder1LineItemsInner cartItem;

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

  ListTile makeLisTile(BuildContext context, {required ShopOrder1LineItemsInner cartItem}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: SizedBox(
        width: 50,
        height: 50,
        child: ImageDisplay(width: 70, height: 70, imageURL: cartItem.image?.src??""),
      ),
      title: Padding(padding: const EdgeInsets.all(5), child: Text(cartItem.name??"")),
      subtitle: Padding(
        padding: const EdgeInsets.all(5),
        child: Wrap(
          direction: Axis.vertical,
          children: [
            Row(children: [
              Text(
                "${cartItem.quantity??0}",
                style: const TextStyle(color: Colors.black),
              ),
              const Text(" x ", style: TextStyle(color: Colors.black)),
              Text(
                "${(cartItem.price?.toStringAsFixed(2)??0) } ريال = ${((cartItem.quantity??0)  * (cartItem.price??0)).toStringAsFixed(2)} ريال",
                textDirection: TextDirection.rtl,
                style: const TextStyle(color: Colors.black),
              ),
            ]),
          ],
        ),
      ),
      trailing: ItemQuantityController(cartItem: cartItem),
    );
  }
}

class ItemQuantityController extends StatelessWidget {
  final ShopOrder1LineItemsInner cartItem;

  const ItemQuantityController({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    var loading = context.read<LoaderProvider>();
    var cart = context.read<CartProvider>();

    return SizedBox(
      width: 120,
      child: CustomStepper(
        quantity: cartItem.quantity??0,
        iconSize: 18,
        lowerLimit: 1,
        upperLimit: 20,
        stepValue: 1,
        onChanged: (value) {
          // TODO: We need debounce so the user can add
          loading.setStatus(true);
          cart.updateQuantity(cartItem.id!, value, onCallback: () => loading.setStatus(false));
        },
        onRemove: () {
          Utils.showMessage(
            context,
            "الأصـــيل",
            "هل أنت متأكد من حذف هذا المنتج من سلة المشتريات؟",
            isConfirmationDialog: true,
            okText: "نعم، اريد حذف المنتج",
            cancelText: "إلغاء",
            onOk: () {
              loading.setStatus(true);
              cart.removeFromCart(cartItem.id!, onCallback: () => loading.setStatus(false));
              Navigator.pop(context);
            },
            onCancel: () => Navigator.pop(context),
            cancelTextStyle: const TextStyle(color: AppColors.accentColor, fontWeight: FontWeight.bold),
            okTextStyle: TextStyle(color: Colors.grey.shade600),
          );
        },
      ),
    );
  }
}
