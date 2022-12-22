import 'package:fgd_flutter/models/thread/creator.dart';

class Comment {
  String? sId;
  String? threadID;
  String? parentID;
  Creator? user;
  String? comment;
  String? createdAt;
  String? updatedAt;
  bool onEdit = false;

  Comment(
      {this.sId,
      this.threadID,
      this.parentID,
      this.user,
      this.comment,
      this.createdAt,
      this.updatedAt});

  Comment.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    threadID = json['threadID'];
    parentID = json['parentID'];
    user = json['user'] != null ? new Creator.fromJson(json['user']) : null;
    comment = json['comment'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['threadID'] = this.threadID;
    data['parentID'] = this.parentID;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['comment'] = this.comment;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
