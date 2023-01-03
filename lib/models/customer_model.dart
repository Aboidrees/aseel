// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CustomerModel {
  String? email;
  String? firstName;
  String? lastName;
  String? password;

  CustomerModel({this.email = "", this.firstName = "", this.lastName = "", this.password = ""});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email ?? "",
      'firstName': firstName ?? "",
      'lastName': lastName ?? "",
      'password': password ?? "",
      'username': email?.split("@")[0] ?? "",
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      email: map['email'] != null ? map['email'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) => CustomerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
