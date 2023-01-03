import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final double? height;
  final double? width;
  final String? imageURL;
  final BorderRadius? borderRadius;
  final BoxFit? fit;

  const ProductImage({
    super.key,
    this.imageURL,
    this.width,
    this.height,
    this.borderRadius,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: FadeInImage(
        height: height,
        width: width,
        fit: fit,
        placeholder: const AssetImage('assets/images/image_placeholder.png'),
        image: NetworkImage(imageURL ?? ""),
        imageErrorBuilder: (_, __, ___) => Image.asset('assets/images/image_placeholder.png', width: width, height: height),
        placeholderErrorBuilder: (_, __, ___) => const Center(child: CircularProgressIndicator()),
        placeholderFit: BoxFit.cover,
      ),
    );
  }
}
