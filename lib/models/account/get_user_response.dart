import 'package:json_annotation/json_annotation.dart';
import 'package:fgd_flutter/models/user/user.dart';

part 'get_user_response.g.dart';

@JsonSerializable()
class GetUserResponse {
  int? status;
  String? message;
  Data? data;

  GetUserResponse({this.status, this.message, this.data});

  GetUserResponse.fromJson(Map<String, dynamic> json) {
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
