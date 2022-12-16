
import 'package:json_annotation/json_annotation.dart';

part 'update_user_response.g.dart';

@JsonSerializable()
class UpdateUserResponse {
  int? status;
  String? message;
  Data? data;

  UpdateUserResponse({this.status, this.message, this.data});

  UpdateUserResponse.fromJson(Map<String, dynamic> json) {
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
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? sId;
  String? email;
  String? userName;
  String? displayName;
  String? biodata;
  String? socialMedia;
  String? profilePictureURL;
  bool? isActive;
  String? role;
  String? createdAt;
  String? updatedAt;

  User(
      {this.sId,
      this.email,
      this.userName,
      this.displayName,
      this.biodata,
      this.socialMedia,
      this.profilePictureURL,
      this.isActive,
      this.role,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    userName = json['userName'];
    displayName = json['displayName'];
    biodata = json['biodata'];
    socialMedia = json['socialMedia'];
    profilePictureURL = json['profilePictureURL'];
    isActive = json['isActive'];
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['userName'] = this.userName;
    data['displayName'] = this.displayName;
    data['biodata'] = this.biodata;
    data['socialMedia'] = this.socialMedia;
    data['profilePictureURL'] = this.profilePictureURL;
    data['isActive'] = this.isActive;
    data['role'] = this.role;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}