import 'package:aseel/constants/colors.dart';
import 'package:aseel/models/cart_model.dart';
import 'package:aseel/models/image_model.dart';
import 'package:aseel/models/product_model.dart';
import 'package:aseel/providers/cart_provider.dart';
import 'package:aseel/providers/loader_provider.dart';
import 'package:aseel/providers/product_provider.dart';
import 'package:aseel/utils/custom_stepper.dart';
import 'package:aseel/utils/expand_text.dart';
import 'package:aseel/utils/util.dart';
import 'package:aseel/widgets/image_display.dart';
import 'package:aseel/widgets/widget_product_card.dart';
import 'package:aseel/widgets/widget_related_products.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetProductDetails extends StatefulWidget {
  const WidgetProductDetails({super.key});

  @override
  State<WidgetProductDetails> createState() => _WidgetProductDetailsState();
}

class _WidgetProductDetailsState extends State<WidgetProductDetails> {
  late int _qty;

  @override
  void initState() {
    _qty = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var style = const TextStyle(fontSize: 12, fontWeight: FontWeight.bold);

    return SingleChildScrollView(
      child: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          var product = provider.currentProduct;
          return Column(
            children: [
              Stack(
                children: [
                  const ProductDetailsImagesSlider(),
                  Visibility(
                    visible: product.calculateDiscount() > 0,
                    child: Positioned(
                      right: 60,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(0)),
                        child: Text("خصم ${product.calculateDiscount()}%", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // name and price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(product.name, textAlign: TextAlign.center, style: style.copyWith(fontSize: 14)),
                        ProductPrice(product: product),
                      ],
                    ),
                    // variations
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: product.type != "variable",
                          child: Column(
                            children: [
                              for (var attribute in product.attributes ?? []) Text("${attribute.name}:  ${attribute.options?.join(" - ")} "),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: product.type == "variable" && Utils.isStable(provider.loadVariationsStatus),
                          child: SelectableTile(
                            label: "اللون",
                            items: provider.productVariations,
                            onPressed: provider.setVariation,
                          ),
                        ),
                        Visibility(
                          visible: product.type == "variable" && Utils.isLoading(provider.loadVariationsStatus),
                          child: Container(width: 20, height: 20, margin: const EdgeInsets.only(right: 30, top: 10), child: const CircularProgressIndicator()),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Add to cart Bar
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
                                  AddToCartModel(id: product.id.toString(), quantity: _qty.toString(), variation: {}),
                                  onCallback: () => context.read<LoaderProvider>().setStatus(false),
                                );
                          },
                          child: const Text("إضافة للسلة", style: TextStyle(color: Colors.white)),
                        )
                      ],
                    ),
                    const SizedBox(height: 5),

                    // Product Details
                    ExpandText(labelHeader: "تفاصيل المنتج", desc: product.description ?? "", shortDesc: product.shortDescription ?? ""),

                    // Related Items
                    Visibility(visible: product.relatedIds?.isNotEmpty ?? false, child: const Divider()),
                    Visibility(
                      visible: product.relatedIds?.isNotEmpty ?? false,
                      child: WidgetRelatedProducts(labelName: "منتجات أخرى", productsIds: product.relatedIds ?? []),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class ProductDetailsImagesSlider extends StatefulWidget {
  const ProductDetailsImagesSlider({super.key});

  @override
  State<ProductDetailsImagesSlider> createState() => _ProductDetailsImagesSliderState();
}

class _ProductDetailsImagesSliderState extends State<ProductDetailsImagesSlider> {
  late CarouselController _carousel;

  @override
  void initState() {
    _carousel = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, controller, child) {
      List<ImageModel> images = controller.currentProduct.images ?? <ImageModel>[];
      switch (images.length) {
        case 0:
          return const ImageDisplay(isPlaceholder: true, height: 300);
        case 1:
          return ImageDisplay(imageURL: images[0].url, height: 300);

        default:
          return Stack(
            children: [
              CarouselSlider.builder(
                itemCount: images.length,
                itemBuilder: (context, index, realIndex) => ImageDisplay(imageURL: images[index].url, height: 300),
                options: CarouselOptions(autoPlay: false, enlargeCenterPage: true, viewportFraction: 1),
                carouselController: _carousel,
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
          );
      }
    });
  }
}

class SelectableTile extends StatefulWidget {
  const SelectableTile({
    super.key,
    required this.label,
    required this.items,
    required this.onPressed,
    this.width,
    this.itemFontSize = 12,
    this.labelFontSize = 14,
    this.labelColor = Colors.black,
  });

  final String label;
  final List<ProductModel> items;
  final Function(ProductModel value) onPressed;
  final double? width;
  final double? itemFontSize;
  final double? labelFontSize;
  final Color? labelColor;

  @override
  State<SelectableTile> createState() => _SelectableTileState();
}

class _SelectableTileState extends State<SelectableTile> {
  //local variable
  late int currentIndex;

  @override
  void initState() {
    currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: TextStyle(color: widget.labelColor, fontSize: widget.labelFontSize, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          runSpacing: 8,
          spacing: 8,
          alignment: WrapAlignment.center,
          children: List.generate(widget.items.length, (index) {
            return GestureDetector(
              onTap: () => setState(() {
                currentIndex = index;

                widget.onPressed(widget.items[index]);
              }),
              child: Container(
                width: widget.width,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 2, color: currentIndex == index ? AppColors.accentColor : Colors.grey.shade200),
                  color: currentIndex == index ? AppColors.accentColor.withOpacity(0.7) : Colors.grey.shade100,
                ),
                child: Text(
                  "${widget.items[index].attributes?.first.option}",
                  style: TextStyle(color: currentIndex == index ? Colors.white : Colors.black, fontSize: widget.itemFontSize),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
