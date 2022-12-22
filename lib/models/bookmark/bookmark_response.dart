import 'package:json_annotation/json_annotation.dart';
import 'package:fgd_flutter/models/thread/thread.dart';

part 'bookmark_response.g.dart';

@JsonSerializable()
class BookmarkResponse {
  int? status;
  String? message;
  Data? data;

  BookmarkResponse({this.status, this.message, this.data});

  BookmarkResponse.fromJson(Map<String, dynamic> json) {
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
  List<Bookmarks>? bookmarks;

  Data({this.bookmarks});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['bookmarks'] != null) {
      bookmarks = <Bookmarks>[];
      json['bookmarks'].forEach((v) {
        bookmarks!.add(new Bookmarks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bookmarks != null) {
      data['bookmarks'] = this.bookmarks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bookmarks {
  String? sId;
  String? userID;
  Thread? thread;

  Bookmarks({this.sId, this.userID, this.thread});

  Bookmarks.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userID = json['userID'];
    thread =
        json['thread'] != null ? new Thread.fromJson(json['thread']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userID'] = this.userID;
    if (this.thread != null) {
      data['thread'] = this.thread!.toJson();
    }
    return data;
  }
}
