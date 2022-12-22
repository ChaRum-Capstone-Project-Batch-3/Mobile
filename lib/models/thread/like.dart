import 'package:fgd_flutter/models/thread/creator.dart';

class Like {
  Creator? user;
  String? timestamp;

  Like({this.user, this.timestamp});

  Like.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new Creator.fromJson(json['user']) : null;
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['timestamp'] = this.timestamp;
    return data;
  }
}
