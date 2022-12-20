import 'package:json_annotation/json_annotation.dart';

part 'comment_response.g.dart';

@JsonSerializable()
class CommentReponse {
  int? status;
  String? message;
  Data? data;

  CommentReponse({this.status, this.message, this.data});

  CommentReponse.fromJson(Map<String, dynamic> json) {
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
  List<Comments>? comments;
  Thread? thread;

  Data({this.comments, this.thread});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
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

class Comments {
  String? sId;
  String? threadID;
  String? parentID;
  User? user;
  String? comment;
  String? createdAt;
  String? updatedAt;

  Comments(
      {this.sId,
      this.threadID,
      this.parentID,
      this.user,
      this.comment,
      this.createdAt,
      this.updatedAt});

  Comments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    threadID = json['threadID'];
    parentID = json['parentID'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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

class User {
  String? sId;
  String? email;
  String? userName;
  String? displayName;
  String? biodata;
  String? socialMedia;
  bool? isActive;
  String? role;
  String? createdAt;
  String? updatedAt;
  String? profilePictureURL;

  User(
      {this.sId,
      this.email,
      this.userName,
      this.displayName,
      this.biodata,
      this.socialMedia,
      this.isActive,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.profilePictureURL});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    userName = json['userName'];
    displayName = json['displayName'];
    biodata = json['biodata'];
    socialMedia = json['socialMedia'];
    isActive = json['isActive'];
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    profilePictureURL = json['profilePictureURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['userName'] = this.userName;
    data['displayName'] = this.displayName;
    data['biodata'] = this.biodata;
    data['socialMedia'] = this.socialMedia;
    data['isActive'] = this.isActive;
    data['role'] = this.role;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['profilePictureURL'] = this.profilePictureURL;
    return data;
  }
}

class Thread {
  String? sId;
  Topic? topic;
  User? creator;
  String? title;
  String? description;
  List<Likes>? likes;
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
        json['creator'] != null ? new User.fromJson(json['creator']) : null;
    title = json['title'];
    description = json['description'];
    if (json['likes'] != null) {
      likes = <Likes>[];
      json['likes'].forEach((v) {
        likes!.add(new Likes.fromJson(v));
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

class Topic {
  String? sId;
  String? topic;
  String? description;
  String? imageURL;
  String? createdAt;
  String? updatedAt;

  Topic(
      {this.sId,
      this.topic,
      this.description,
      this.imageURL,
      this.createdAt,
      this.updatedAt});

  Topic.fromJson(Map<String, dynamic> json) {
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

class Likes {
  User? user;
  String? timestamp;

  Likes({this.user, this.timestamp});

  Likes.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['timestamp'] = this.timestamp;
    return data;
  }
}
