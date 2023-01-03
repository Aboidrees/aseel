import 'dart:convert';

import 'package:aseel/models/image_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Category {
  int id;
  String? name;
  String? description;
  int? parent;
  ImageModel? image;

  Category({
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

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int,
      name: map['name'] != null ? map['name'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      parent: map['parent'] != null ? map['parent'] as int : null,
      image: map['image'] != null ? ImageModel.fromMap(map['image'] as Map<String, dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) => Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Category(id: $id, name: $name, description: $description, parent: $parent, image: $image)';
  }

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.description == description && other.parent == parent && other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ description.hashCode ^ parent.hashCode ^ image.hashCode;
  }
}
