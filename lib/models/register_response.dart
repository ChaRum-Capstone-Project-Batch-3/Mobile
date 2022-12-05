import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  int? status;
  String? message;
  Data? data;

  RegisterResponse({this.status, this.message, this.data});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? field;
  String? token;
  User? user;

  Data({this.field, this.token, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    field = json['field'];
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['field'] = this.field;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? email;
  String? userName;
  String? displayName;
  String? password;
  bool? isActive;
  String? role;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.email,
      this.userName,
      this.displayName,
      this.password,
      this.isActive,
      this.role,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    userName = json['userName'];
    displayName = json['displayName'];
    password = json['password'];
    isActive = json['isActive'];
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['userName'] = this.userName;
    data['displayName'] = this.displayName;
    data['password'] = this.password;
    data['isActive'] = this.isActive;
    data['role'] = this.role;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
