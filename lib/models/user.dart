import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class Users {
  String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI2MzhiMzIxOGU5ODc3MGZlYzMzNGM2ZGQiLCJpc3MiOiJjaGFydW0iLCJleHAiOjE2NzAwNzAzODYsIm5iZiI6MTY3MDA2Njc4NiwiaWF0IjoxNjcwMDY2Nzg2fQ.9QxTu9ZYEqse8KTiVzo1DmqIWAHNXJQ5GTkPVehrp40";

  Users({required this.token});

  Users.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}
