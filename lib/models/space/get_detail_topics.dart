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
  DetailTopic? topic;

  Data({this.topic});

  Data.fromJson(Map<String, dynamic> json) {
    topic = json['topic'] != null ? new DetailTopic.fromJson(json['topic']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topic != null) {
      data['topic'] = this.topic!.toJson();
    }
    return data;
  }
}

class DetailTopic {
  String? sId;
  String? topic;
  String? description;
  String? createdAt;
  String? updatedAt;

  DetailTopic(
      {this.sId, this.topic, this.description, this.createdAt, this.updatedAt});

  DetailTopic.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    topic = json['topic'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['topic'] = this.topic;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
