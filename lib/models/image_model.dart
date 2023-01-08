import 'dart:convert';

class ImageModel {
  String? url;

  ImageModel({this.url});

  Map<String, dynamic> toMap() => <String, dynamic>{'url': url};

  factory ImageModel.fromMap(Map<String, dynamic> map) => ImageModel(url: map['src']?.toString() ?? "");

  String toJson() => json.encode(toMap());

  factory ImageModel.fromJson(String source) => ImageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Image(url: $url)';

  @override
  bool operator ==(covariant ImageModel other) {
    if (identical(this, other)) return true;

    return other.url == url;
  }

  @override
  int get hashCode => url.hashCode;
}
