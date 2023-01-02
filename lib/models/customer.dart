// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Customer {
  String? email;
  String? firstName;
  String? lastName;
  String? password;

  Customer({
    this.email = "",
    this.firstName = "",
    this.lastName = "",
    this.password = "",
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email ?? "",
      'firstName': firstName ?? "",
      'lastName': lastName ?? "",
      'password': password ?? "",
      'username': email?.split("@")[0] ?? "",
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      email: map['email'] != null ? map['email'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) => Customer.fromMap(json.decode(source) as Map<String, dynamic>);
}
