
import 'package:fgd_flutter/models/topic/topic.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_detail_topics.g.dart';

@JsonSerializable()
class getDetailTopics {
  int? status;
  String? message;
  Data? data;

  getDetailTopics({this.status, this.message, this.data});

  getDetailTopics.fromJson(Map<String, dynamic> json) {
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
  Topic? topic;

  Data({this.topic});

  Data.fromJson(Map<String, dynamic> json) {
    topic = json['topic'] != null ? new Topic.fromJson(json['topic']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topic != null) {
      data['topic'] = this.topic!.toJson();
    }
    return data;
  }
}

