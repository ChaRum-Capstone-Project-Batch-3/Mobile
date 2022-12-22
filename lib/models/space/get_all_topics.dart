import 'package:fgd_flutter/models/topic/topic.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_topics.g.dart';

@JsonSerializable()
class GetTopics {
  int? status;
  String? message;
  Data? data;
  Pagination? pagination;

  GetTopics({this.status, this.message, this.data, this.pagination});

  GetTopics.fromJson(Map<String, dynamic> json) {
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
  List<Topic>? topics;

  Data({this.topics});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['topics'] != null) {
      topics = <Topic>[];
      json['topics'].forEach((v) {
        topics!.add(new Topic.fromJson(v));
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