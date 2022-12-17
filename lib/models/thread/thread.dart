import 'package:fgd_flutter/models/thread/like.dart';
import 'package:fgd_flutter/models/thread/creator.dart';
import 'package:fgd_flutter/models/topic/topic.dart';

class Thread {
  String? sId;
  Topic? topic;
  Creator? creator;
  String? title;
  String? description;
  List<Like>? likes;
  String? imageURL;
  bool? isLiked;
  bool? isBookmarked;
  bool? isFollowed;
  int? totalLike;
  int? totalFollow;
  int? totalComment;
  int? totalBookmark;
  String? createdAt;
  String? updatedAt;

  Thread(
      {this.sId,
      this.topic,
      this.creator,
      this.title,
      this.description,
      this.likes,
      this.imageURL,
      this.isLiked,
      this.isBookmarked,
      this.isFollowed,
      this.totalLike,
      this.totalFollow,
      this.totalComment,
      this.totalBookmark,
      this.createdAt,
      this.updatedAt});

  Thread.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    topic = json['topic'] != null ? new Topic.fromJson(json['topic']) : null;
    creator =
        json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    title = json['title'];
    description = json['description'];
    if (json['likes'] != null) {
      likes = <Like>[];
      json['likes'].forEach((v) {
        likes!.add(new Like.fromJson(v));
      });
    }
    imageURL = json['imageURL'];
    isLiked = json['isLiked'];
    isBookmarked = json['isBookmarked'];
    isFollowed = json['isFollowed'];
    totalLike = json['totalLike'];
    totalFollow = json['totalFollow'];
    totalComment = json['totalComment'];
    totalBookmark = json['totalBookmark'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.topic != null) {
      data['topic'] = this.topic!.toJson();
    }
    if (this.creator != null) {
      data['creator'] = this.creator!.toJson();
    }
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.likes != null) {
      data['likes'] = this.likes!.map((v) => v.toJson()).toList();
    }
    data['imageURL'] = this.imageURL;
    data['isLiked'] = this.isLiked;
    data['isBookmarked'] = this.isBookmarked;
    data['isFollowed'] = this.isFollowed;
    data['totalLike'] = this.totalLike;
    data['totalFollow'] = this.totalFollow;
    data['totalComment'] = this.totalComment;
    data['totalBookmark'] = this.totalBookmark;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
