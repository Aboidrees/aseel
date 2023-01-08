import 'dart:convert';

import 'package:aseel/models/image_model.dart';

class CategoryModel {
  int id;
  String? name;
  String? description;
  int? parent;
  ImageModel? image;

  CategoryModel({
    required this.id,
    this.name,
    this.description,
    this.parent,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'parent': parent,
      'image': image?.toMap(),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as int,
      name: map['name'] != null ? map['name'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      parent: map['parent'] != null ? map['parent'] as int : null,
      image: map['image'] != null ? ImageModel.fromMap(map['image'] as Map<String, dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) => CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Category(id: $id, name: $name, description: $description, parent: $parent, image: $image)';
  }

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.description == description && other.parent == parent && other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ description.hashCode ^ parent.hashCode ^ image.hashCode;
  }
}
