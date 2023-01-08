// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:aseel/models/attribute_model.dart';
import 'package:flutter/foundation.dart';

class VariableProductModel {
  int id;
  String? sku;
  String? price;
  String? regularPrice;
  String? salePrice;
  List<AttributeModel>? attributes;

  VariableProductModel({
    required this.id,
    this.sku,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.attributes,
  });

  VariableProductModel copyWith({
    int? id,
    String? sku,
    String? price,
    String? regularPrice,
    String? salePrice,
    List<AttributeModel>? attributes,
  }) {
    return VariableProductModel(
      id: id ?? this.id,
      sku: sku ?? this.sku,
      price: price ?? this.price,
      regularPrice: regularPrice ?? this.regularPrice,
      salePrice: salePrice ?? this.salePrice,
      attributes: attributes ?? this.attributes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sku': sku,
      'price': price,
      'regularPrice': regularPrice,
      'salePrice': salePrice,
      'attributes': attributes?.map((x) => x.toMap()).toList(),
    };
  }

  factory VariableProductModel.fromMap(Map<String, dynamic> map) {
    return VariableProductModel(
      id: int.tryParse(map['id'].toString()) ?? 0,
      sku: map['sku'] != null ? map['sku'] as String : null,
      price: map['price']?.toString(),
      regularPrice: map['regularPrice']?.toString(),
      salePrice: map['salePrice']?.toString(),
      attributes: List<AttributeModel>.from((map['attributes']).map((x) => AttributeModel.fromMap(x as Map<String, dynamic>))),
    );
  }

  String toJson() => json.encode(toMap());

  factory VariableProductModel.fromJson(String source) => VariableProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VariableProductModel(id: $id, sku: $sku, price: $price, regularPrice: $regularPrice, salePrice: $salePrice, attributes: $attributes)';
  }

  @override
  bool operator ==(covariant VariableProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.sku == sku &&
        other.price == price &&
        other.regularPrice == regularPrice &&
        other.salePrice == salePrice &&
        listEquals(other.attributes, attributes);
  }

  @override
  int get hashCode {
    return id.hashCode ^ sku.hashCode ^ price.hashCode ^ regularPrice.hashCode ^ salePrice.hashCode ^ attributes.hashCode;
  }
}
