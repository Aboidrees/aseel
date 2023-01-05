import 'package:aseel/r.dart';
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
        fit: fit,
        height: height,
        width: width ?? double.infinity,
        image: NetworkImage(imageURL ?? ""),
        placeholder: const AssetImage(AssetImages.imagePlaceholder),
        imageErrorBuilder: (_, __, ___) => Image.asset(AssetImages.imagePlaceholder, width: width, height: height),
        placeholderErrorBuilder: (_, __, ___) => const Center(child: CircularProgressIndicator()),
        placeholderFit: BoxFit.cover,
      ),
    );
  }
}
