import 'package:aseel/constants/colors.dart';
import 'package:aseel/models/cart_model.dart';
import 'package:aseel/models/image_model.dart';
import 'package:aseel/models/product_model.dart';
import 'package:aseel/providers/cart_provider.dart';
import 'package:aseel/providers/loader_provider.dart';
import 'package:aseel/providers/product_provider.dart';
import 'package:aseel/utils/custom_stepper.dart';
import 'package:aseel/utils/expand_text.dart';
import 'package:aseel/widgets/image_display.dart';
import 'package:aseel/widgets/widget_related_products.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetProductDetails extends StatefulWidget {
  const WidgetProductDetails({super.key, required this.product});

  final ProductModel product;

  @override
  State<WidgetProductDetails> createState() => _WidgetProductDetailsState();
}

class _WidgetProductDetailsState extends State<WidgetProductDetails> {
  final _carousel = CarouselController();
  late int _qty;

  @override
  void initState() {
    _qty = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _productImagesSlider(widget.product.images ?? [ImageModel(url: "")], context),
                Visibility(
                  visible: widget.product.calculateDiscount() > 0,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(0)),
                      child: Text("خصم ${widget.product.calculateDiscount()}%", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                // name and price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.product.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${widget.product.salePrice} ريال ",
                      style: const TextStyle(fontSize: 16, color: AppColors.accentColor, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                // variations
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: widget.product.type != "variable",
                      child: Column(
                        children: [for (var attribute in widget.product.attributes ?? []) Text("${attribute.name}:  ${attribute.options?.join(" - ")} ")],
                      ),
                    ),
                    Visibility(
                      visible: widget.product.type == "variable",
                      child: selectDropDown(
                        context,
                        initialValue: "",
                        items: context.read<ProductProvider>().productVariations,
                        onChanged: (ProductModel product) {
                          widget.product.price = product.price;
                          widget.product.salePrice = product.salePrice;
                          widget.product.regularPrice = product.regularPrice;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomStepper(
                      quantity: 1,
                      lowerLimit: 1,
                      upperLimit: 20,
                      stepValue: 1,
                      iconSize: 22.0,
                      onChanged: (value) => setState(() => _qty = value),
                    ),
                    MaterialButton(
                      height: 45,
                      color: AppColors.accentColor,
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      shape: const StadiumBorder(),
                      onPressed: () {
                        context.read<LoaderProvider>().setStatus(true);

                        context
                            .read<CartProvider>() //
                            .addToCart(
                              AddToCartModel(id: widget.product.id.toString(), quantity: _qty.toString(), variation: {}),
                              onCallback: () => context.read<LoaderProvider>().setStatus(false),
                            );
                      },
                      child: const Text("إضافة للسلة", style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                ExpandText(
                  labelHeader: "تفاصيل المنتج",
                  desc: widget.product.description ?? "",
                  shortDesc: widget.product.shortDescription ?? "",
                ),
                Visibility(visible: widget.product.relatedIds?.isNotEmpty ?? false, child: const Divider()),
                Visibility(
                  visible: widget.product.relatedIds?.isNotEmpty ?? false,
                  child: WidgetRelatedProducts(labelName: "منتجات أخرى", productsIds: widget.product.relatedIds ?? []),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _productImagesSlider(List<ImageModel> images, BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: CarouselSlider.builder(
              itemCount: images.length,
              itemBuilder: (context, index, realIndex) => ImageDisplay(imageURL: images[index].url),
              options: CarouselOptions(autoPlay: false, enlargeCenterPage: true, viewportFraction: 1, aspectRatio: 1),
              carouselController: _carousel,
            ),
          ),
          Visibility(
            visible: images.length > 1,
            child: Positioned(
              top: 100,
              right: 10,
              child: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: _carousel.previousPage),
            ),
          ),
          Visibility(
            visible: images.length > 1,
            child: Positioned(
              top: 100,
              left: 10,
              child: IconButton(icon: const Icon(Icons.arrow_forward_ios), onPressed: _carousel.nextPage),
            ),
          ),
        ],
      ),
    );
  }

  static Widget selectDropDown(
    BuildContext context, {
    dynamic items,
    Object? initialValue,
    Function? onChanged,
    String Function(ProductModel?)? onValidate,
  }) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        height: 75,
        width: 150,
        padding: const EdgeInsets.only(top: 5),
        child: DropdownButtonFormField<ProductModel>(
          hint: const Text(' اختر'),
          value: null,
          isDense: true,
          decoration: fieldDecoration(context, '', ''),
          onChanged: (ProductModel? product) {
            FocusScope.of(context).requestFocus(FocusNode());
            onChanged!(product);
          },
          validator: onValidate,
          items: items?.map<DropdownMenuItem<ProductModel>>((ProductModel product) {
                return DropdownMenuItem(value: product, child: Text("${product.attributes?.first.option}  ${product.attributes?.first.name}"));
              }).toList() ??
              [],
        ),
      ),
    );
  }

  static InputDecoration fieldDecoration(
    BuildContext context,
    String hintText,
    String helperText, {
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(6),
      hintText: hintText,
      helperText: helperText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.accentColor, width: 1)),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.accentColor, width: 1)),
    );
  }
}
