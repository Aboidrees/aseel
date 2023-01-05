import 'package:aseel/constants/colors.dart';
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
    Provider.of<CartProvider>(context, listen: false)
      ..resetStream()
      ..updateCartDetails();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoaderProvider>(
      builder: (context, controller, child) {
        return Scaffold(
          body: ProgressHUD(
            inAsyncCall: controller.isApiCallProcess,
            opacity: 0.3,
            child: _cartItemsList(),
          ),
        );
      },
    );
  }

  Widget _cartItemsList() {
    return Consumer<CartProvider>(
      builder: (context, controller, child) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: controller.items.length,
                    itemBuilder: (context, index) => WidgetCartProduct(cartItem: controller.items[index]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        color: Colors.green.shade800,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        onPressed: () {
                          Provider.of<LoaderProvider>(context, listen: false).setStatus(true);
                          var cartProvider = Provider.of<CartProvider>(context, listen: false);

                          cartProvider.updateCartDetails(onCallback: () {
                            Provider.of<LoaderProvider>(context, listen: false).setStatus(false);
                          });
                        },
                        child: Wrap(
                          alignment: WrapAlignment.end,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: const [
                            Icon(Icons.sync, color: Colors.white),
                            Text("تحديث سلة المشتريات", style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const CheckoutButton()
            ],
          ),
        );
      },
    );
  }
}

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
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
          children: [
            const Text(' دفع ', style: TextStyle(color: Colors.white, fontSize: 18)),
            Consumer<CartProvider>(builder: (_, controller, child) {
              return Text(' ${controller.totalAmount} ', style: const TextStyle(color: Colors.white, fontSize: 18));
            }),
            const Text(' ريال', style: TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
