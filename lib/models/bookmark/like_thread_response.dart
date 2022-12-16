import 'package:json_annotation/json_annotation.dart';

part 'like_thread_response.g.dart';

@JsonSerializable()
class LikeThreadResponse {
  int? status;
  String? message;

  LikeThreadResponse({this.status, this.message});

  LikeThreadResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
