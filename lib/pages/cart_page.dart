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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: controller.cartDetails?.items?.length ?? 0,
                    itemBuilder: (context, index) {
                      if (controller.cartDetails?.items?.isNotEmpty ?? false) {
                        return CartProduct(cartItem: controller.cartDetails!.items![index]);
                      }

                      return const Center(child: Text("سلة المشتريات فارغة"));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        color: Colors.green.shade800,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        onPressed: () {},
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
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("المجموع: ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            Text(' ريال'),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
