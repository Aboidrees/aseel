// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AttributeModel {
  int id;
  String? name;
  bool? visible;
  List<String>? options;
  String? option;

  AttributeModel({required this.id, this.name, this.visible, this.options, this.option});

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'name': name,
        'visible': visible,
        'options': options,
        'option': option,
      };

  factory AttributeModel.fromMap(Map<String, dynamic> map) {
    return AttributeModel(
      id: map['id'] as int,
      name: map['name'].toString(),
      visible: map['visible'] ?? false,
      options: List<String>.from((map['options']?.toList() ?? [])),
      option: map['option']?.toString() ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory AttributeModel.fromJson(String source) => AttributeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Attribute(id: $id, name: $name, visible: $visible, options: $options)';
  }
}
