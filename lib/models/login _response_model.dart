import 'dart:convert';

class LoginResponseModel {
  bool success;
  int statusCode;
  String code;
  String message;
  DataModel? data;
  LoginResponseModel({
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

  factory LoginResponseModel.fromMap(Map<String, dynamic> map) {
    return LoginResponseModel(
      success: map['success'] as bool,
      statusCode: map['statusCode'] as int,
      code: map['code'] as String,
      message: map['message'] as String,
      data: map['data'] != null ? DataModel.fromMap(map['data'] as Map<String, dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponseModel.fromJson(String source) => LoginResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class DataModel {
  String token;
  int id;
  String email;
  String nicename;
  String? firstName;
  String? lastName;
  String? displayName;

  DataModel({
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

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
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

  factory DataModel.fromJson(String source) => DataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
