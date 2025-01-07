import 'package:aseel/constants/colors.dart';
import 'package:aseel/models/cart_model.dart';
import 'package:aseel/providers/cart_provider.dart';
import 'package:aseel/providers/loader_provider.dart';
import 'package:aseel/utils/progress_hud.dart';
import 'package:aseel/widgets/widget_cart_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () => Provider.of<LoaderProvider>(context, listen: false).setStatus(true));

    Provider.of<CartProvider>(context, listen: false).updateCartDetails(
      onCallback: () => Provider.of<LoaderProvider>(context, listen: false).setStatus(false),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressHUD(
        inAsyncCall: context.watch<LoaderProvider>().isApiCallProcess,
        opacity: 0.3,
        child: const Column(
          children: [
            CartItemsList(),
            CheckoutButton(),
          ],
        ),
      ),
    );
  }
}

class CartItemsList extends StatelessWidget {
  const CartItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Selector<CartProvider, List<CartItemModel>>(
        selector: (context, cart) => cart.items,
        builder: (context, items, child) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: items.length,
            itemBuilder: (context, index) => WidgetCartProduct(cartItem: items[index]),
          );
        },
      ),
    );
  }
}

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    var style = const TextStyle(color: Colors.white, fontSize: 18);
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      child: MaterialButton(
        color: AppColors.accentColor,
        shape: const StadiumBorder(),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(' دفع ', style: style),
            Selector<CartProvider, double>(
              selector: (context, cart) => cart.totalAmount,
              builder: (context, total, child) => Text(' ($total) ', style: style),
            ),
            Text(' ريال', style: style),
          ],
        ),
      ),
    );
  }
}
