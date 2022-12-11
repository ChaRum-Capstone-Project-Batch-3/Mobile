import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class Login {
  String? key;
  String? password;

  Login({this.key, this.password});

  Login.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['password'] = this.password;
    return data;
  }
}
