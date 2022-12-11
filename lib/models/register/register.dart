import 'package:json_annotation/json_annotation.dart';
part 'register.g.dart';

@JsonSerializable()
class Register {
  String? email;
  String? userName;
  String? displayName;
  String? password;

  Register({this.email, this.userName, this.displayName, this.password});

  Register.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    userName = json['userName'];
    displayName = json['displayName'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['userName'] = this.userName;
    data['displayName'] = this.displayName;
    data['password'] = this.password;
    return data;
  }
}
