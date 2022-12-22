import 'package:json_annotation/json_annotation.dart';

part 'topic_response.g.dart';

@JsonSerializable()
class TopicResponse {
  int? status;
  String? message;
  Data? data;
  Pagination? pagination;

  TopicResponse({this.status, this.message, this.data, this.pagination});

  TopicResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Data {
  List<Topics>? topics;

  Data({this.topics});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['topics'] != null) {
      topics = <Topics>[];
      json['topics'].forEach((v) {
        topics!.add(new Topics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topics != null) {
      data['topics'] = this.topics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Topics {
  String? sId;
  String? topic;
  String? description;
  String? imageURL;
  String? createdAt;
  String? updatedAt;
  bool isSelected = false;

  Topics(
      {this.sId,
      this.topic,
      this.description,
      this.imageURL,
      this.createdAt,
      this.updatedAt});

  Topics.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    topic = json['topic'];
    description = json['description'];
    imageURL = json['imageURL'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['topic'] = this.topic;
    data['description'] = this.description;
    data['imageURL'] = this.imageURL;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Pagination {
  int? size;
  int? totalData;
  int? currentPage;
  int? totalPage;

  Pagination({this.size, this.totalData, this.currentPage, this.totalPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    totalData = json['totalData'];
    currentPage = json['currentPage'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['totalData'] = this.totalData;
    data['currentPage'] = this.currentPage;
    data['totalPage'] = this.totalPage;
    return data;
  }
}
