import 'package:json_annotation/json_annotation.dart';
import 'package:fgd_flutter/models/thread/thread.dart';

part 'thread_response.g.dart';

@JsonSerializable()
class ThreadResponse {
  int? status;
  String? message;
  Data? data;
  Pagination? pagination;

  ThreadResponse({this.status, this.message, this.data, this.pagination});

  ThreadResponse.fromJson(Map<String, dynamic> json) {
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
  List<Thread>? threads;

  Data({this.threads});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['threads'] != null) {
      threads = <Thread>[];
      json['threads'].forEach((v) {
        threads!.add(new Thread.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.threads != null) {
      data['threads'] = this.threads!.map((v) => v.toJson()).toList();
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
