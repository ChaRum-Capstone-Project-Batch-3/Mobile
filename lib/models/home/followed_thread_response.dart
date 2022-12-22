import 'package:fgd_flutter/models/thread/creator.dart';
import 'package:fgd_flutter/models/thread/thread.dart';
import 'package:json_annotation/json_annotation.dart';

part 'followed_thread_response.g.dart';

@JsonSerializable()
class FollowedThreadResponse {
  int? status;
  String? message;
  Data? data;

  FollowedThreadResponse({this.status, this.message, this.data});

  FollowedThreadResponse.fromJson(Map<String, dynamic> json) {
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
  List<FollowThreads>? followThreads;

  Data({this.followThreads});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['followThreads'] != null) {
      followThreads = <FollowThreads>[];
      json['followThreads'].forEach((v) {
        followThreads!.add(new FollowThreads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.followThreads != null) {
      data['followThreads'] =
          this.followThreads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FollowThreads {
  String? sId;
  Creator? user;
  Thread? thread;
  int? notification;
  String? createdAt;
  String? updatedAt;

  FollowThreads(
      {this.sId,
      this.user,
      this.thread,
      this.notification,
      this.createdAt,
      this.updatedAt});

  FollowThreads.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? new Creator.fromJson(json['user']) : null;
    thread =
        json['thread'] != null ? new Thread.fromJson(json['thread']) : null;
    notification = json['notification'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.thread != null) {
      data['thread'] = this.thread!.toJson();
    }
    data['notification'] = this.notification;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
