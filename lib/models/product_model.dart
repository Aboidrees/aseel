// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:aseel/models/category.dart';
import 'package:aseel/models/image_model.dart';

class ProductModel {
  int id;
  String name;
  String? description;
  String? shortDescription;
  String? sku;
  String? price;
  String? regularPrice;
  String? salePrice;
  String? stockStatus;

  List<ImageModel>? images;
  List<Category>? categories;
  List<Attribute>? attributes;
  List<int>? relatedIds;

  ProductModel({
    required this.id,
    required this.name,
    this.description,
    this.shortDescription,
    this.sku,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.stockStatus,
    this.images,
    this.categories,
    this.attributes,
    this.relatedIds,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'shortDescription': shortDescription,
      'sku': sku,
      'price': price,
      'regularPrice': regularPrice,
      'salePrice': salePrice,
      'stockStatus': stockStatus,
      'images': images?.map((x) => x.toMap()).toList(),
      'categories': categories?.map((x) => x.toMap()).toList(),
      'attributes': attributes?.map((x) => x.toMap()).toList(),
      'relatedIds': relatedIds?.toList(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] != null ? map['description'] as String : null,
      shortDescription: map['short_description'] != null ? map['short_description'] as String : null,
      sku: map['sku'] != null ? map['sku'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      regularPrice: map['regular_price'] != null ? map['regular_price'] as String : null,
      salePrice: map['sale_price'] != null ? map['sale_price'] as String : map['regular_price'] ?? "",
      stockStatus: map['stock_status'] != null ? map['stock_status'] as String : null,
      images: map['images'] != null ? List<ImageModel>.from((map['images']).map((x) => ImageModel.fromMap(x as Map<String, dynamic>))) : null,
      categories: map['categories'] != null ? List<Category>.from((map['categories']).map((x) => Category.fromMap(x as Map<String, dynamic>))) : null,
      attributes: map['attributes'] != null ? List<Attribute>.from((map['attributes']).map((x) => Attribute.fromMap(x as Map<String, dynamic>))) : null,
      relatedIds: map['cross_sell_ids'].cast<int>() ?? <int>[],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, shortDescription: $shortDescription, sku: $sku, price: $price, regularPrice: $regularPrice, salePrice: $salePrice, stockStatus: $stockStatus, images: $images, categories: $categories)';
  }

  int calculateDiscount() {
    double regularPrice = double.tryParse(this.regularPrice.toString()) ?? 0;
    double salePrice = double.tryParse(this.salePrice.toString()) ?? regularPrice;
    double discount = regularPrice - salePrice;
    if (discount <= 0.0) return 0;

    double discountPercent = (discount / regularPrice) * 100;
    return discountPercent.round();
  }
}

class Attribute {
  int id;
  String? name;
  bool? visible;
  List<String>? options;

  Attribute({required this.id, this.name, this.visible, this.options});

  Map<String, dynamic> toMap() => <String, dynamic>{'id': id, 'name': name, 'visible': visible, 'options': options};

  factory Attribute.fromMap(Map<String, dynamic> map) {
    return Attribute(
      id: map['id'] as int,
      name: map['name'].toString(),
      visible: map['visible'] ?? false,
      options: List<String>.from((map['options'] as List)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Attribute.fromJson(String source) => Attribute.fromMap(json.decode(source) as Map<String, dynamic>);
}
