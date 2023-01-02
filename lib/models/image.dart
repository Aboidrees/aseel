import 'dart:convert';

class Image {
  String? url;
  Image({
    this.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
    };
  }

  factory Image.fromMap(Map<String, dynamic> map) {
    return Image(
      url: map['src'] != null ? map['src'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Image.fromJson(String source) => Image.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Image(url: $url)';

  @override
  bool operator ==(covariant Image other) {
    if (identical(this, other)) return true;

    return other.url == url;
  }

  @override
  int get hashCode => url.hashCode;
}
