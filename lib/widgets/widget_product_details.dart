import 'package:aseel/models/image.dart' as imageModel;
import 'package:aseel/models/product.dart';
import 'package:aseel/widgets/product_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class WidgetProductDetails extends StatelessWidget {
  WidgetProductDetails({super.key, required this.product});

  final Product product;
  final _carousel = CarouselController();

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
                _productImagesSlider(product.images ?? [imageModel.Image(url: "")], context),
                Visibility(
                  visible: product.calculateDiscount() > 0,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(0)),
                      child: Text("خصم ${product.calculateDiscount()}%", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  product.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _productImagesSlider(List<imageModel.Image> images, BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: CarouselSlider.builder(
              itemCount: images.length,
              itemBuilder: (context, index, realIndex) => ProductImage(imageURL: images[index].url, fit: BoxFit.fill),
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
}
