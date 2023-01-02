import 'dart:convert';

class LoginResponse {
  bool success;
  int statusCode;
  String code;
  String message;
  Data? data;
  LoginResponse({
    required this.success,
    required this.statusCode,
    required this.code,
    required this.message,
    this.data,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'success': success,
      'statusCode': statusCode,
      'code': code,
      'message': message,
    };

    if (data != null) {
      map['data'] = data?.toJson();
    }

    return map;
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      success: map['success'] as bool,
      statusCode: map['statusCode'] as int,
      code: map['code'] as String,
      message: map['message'] as String,
      data: map['data'] != null ? Data.fromMap(map['data'] as Map<String, dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) => LoginResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Data {
  String token;
  int id;
  String email;
  String nicename;
  String? firstName;
  String? lastName;
  String? displayName;

  Data({
    this.token = "",
    this.id = -1,
    this.email = "",
    this.nicename = "",
    this.firstName = "",
    this.lastName = "",
    this.displayName = "",
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'id': id,
      'email': email,
      'nicename': nicename,
      'firstName': firstName,
      'lastName': lastName,
      'displayName': displayName,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      token: map['token'] as String,
      id: map['id'] as int,
      email: map['email'] as String,
      nicename: map['nicename'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      displayName: map['displayName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source) as Map<String, dynamic>);
}
