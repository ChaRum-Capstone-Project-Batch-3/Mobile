import 'package:fgd_flutter/models/thread/comment.dart';
import 'package:fgd_flutter/models/thread/thread.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_thread_detail_response.g.dart';

@JsonSerializable()
class GetThreadDetailResponse {
  int? status;
  String? message;
  Data? data;

  GetThreadDetailResponse({this.status, this.message, this.data});

  GetThreadDetailResponse.fromJson(Map<String, dynamic> json) {
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
  Thread? thread;
  List<Comment>? comments;

  Data({this.comments, this.thread});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['comments'] != null) {
      comments = <Comment>[];
      json['comments'].forEach((v) {
        comments!.add(new Comment.fromJson(v));
      });
    }
    thread =
        json['thread'] != null ? new Thread.fromJson(json['thread']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    if (this.thread != null) {
      data['thread'] = this.thread!.toJson();
    }
    return data;
  }
}
