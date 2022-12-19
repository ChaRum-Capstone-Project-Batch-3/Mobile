import 'package:json_annotation/json_annotation.dart';

part 'update_user_model.g.dart';

@JsonSerializable()
class UpdateUserModel {
  String? email;
  String? userName;
  String? displayName;
  String? biodata;
  String? socialMedia;
  String? profilePictureURL;

  UpdateUserModel(
      {this.email,
      this.userName,
      this.displayName,
      this.biodata,
      this.socialMedia,
      this.profilePictureURL});

  UpdateUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    userName = json['userName'];
    displayName = json['displayName'];
    biodata = json['biodata'];
    socialMedia = json['socialMedia'];
    profilePictureURL = json['profilePictureURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['userName'] = this.userName;
    data['displayName'] = this.displayName;
    data['biodata'] = this.biodata;
    data['socialMedia'] = this.socialMedia;
    data['profilePictureURL'] = this.profilePictureURL;
    return data;
  }
}
