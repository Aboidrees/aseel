// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:aseel/models/attribute_model.dart';
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

  ImageModel? image;

  List<ImageModel>? images;
  List<CategoryModel>? categories;
  List<AttributeModel>? attributes;
  List<int>? relatedIds;
  String? type;

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
    this.image,
    this.images,
    this.categories,
    this.attributes,
    this.relatedIds,
    this.type,
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
      'image': image,
      'images': images?.map((x) => x.toMap()).toList(),
      'categories': categories?.map((x) => x.toMap()).toList(),
      'attributes': attributes?.map((x) => x.toMap()).toList(),
      'relatedIds': relatedIds?.toList(),
      'type': type?.toString(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      sku: map['sku']?.toString() ?? "",
      name: map['name']?.toString() ?? map['title']?.toString() ?? "",
      price: map['price']?.toString() ?? "",
      description: map['description']?.toString() ?? "",
      shortDescription: map['short_description']?.toString() ?? "",
      regularPrice: map['regular_price']?.toString() ?? "",
      salePrice: map['sale_price']?.toString() ?? map['regular_price']?.toString() ?? map['price']?.toString() ?? "",
      stockStatus: map['stock_status']?.toString(),
      image: map['image'] != null ? ImageModel.fromMap(map['image']) : null,
      images: List.from((map['images'])?.map((x) => ImageModel.fromMap(x as Map<String, dynamic>)) ?? []),
      categories: List.from((map['categories'])?.map((x) => CategoryModel.fromMap(x as Map<String, dynamic>)) ?? []),
      attributes: List.from((map['attributes'])?.map((x) => AttributeModel.fromMap(x as Map<String, dynamic>))),
      relatedIds: map['cross_sell_ids']?.cast<int>() ?? <int>[],
      type: map['type']?.toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, shortDescription: $shortDescription, sku: $sku, price: $price, regularPrice: $regularPrice, salePrice: $salePrice, stockStatus: $stockStatus, images: $image,image: $images, categories: $categories, type: $type)';
  }

  int calculateDiscount() {
    double regularPrice = double.tryParse(this.regularPrice.toString()) ?? 0;
    double salePrice = double.tryParse(this.salePrice.toString()) ?? regularPrice;
    double discount = regularPrice - salePrice;
    if (discount <= 0.0) return 0;

    double discountPercent = (discount / regularPrice) * 100;
    return discountPercent.round();
  }

  ProductModel copyWith({
    int? id,
    String? name,
    String? description,
    String? shortDescription,
    String? sku,
    String? price,
    String? regularPrice,
    String? salePrice,
    String? stockStatus,
    List<ImageModel>? images,
    ImageModel? image,
    List<CategoryModel>? categories,
    List<AttributeModel>? attributes,
    List<int>? relatedIds,
    String? type,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      shortDescription: shortDescription ?? this.shortDescription,
      sku: sku ?? this.sku,
      price: price ?? this.price,
      regularPrice: regularPrice ?? this.regularPrice,
      salePrice: salePrice ?? this.salePrice,
      stockStatus: stockStatus ?? this.stockStatus,
      images: images ?? this.images,
      image: image ?? this.image,
      categories: categories ?? this.categories,
      attributes: attributes ?? this.attributes,
      relatedIds: relatedIds ?? this.relatedIds,
      type: type ?? this.type,
    );
  }
}
