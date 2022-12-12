import 'package:json_annotation/json_annotation.dart';

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
  List<Threads>? threads;

  Data({this.threads});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['threads'] != null) {
      threads = <Threads>[];
      json['threads'].forEach((v) {
        threads!.add(new Threads.fromJson(v));
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

class Threads {
  String? sId;
  Topic? topic;
  Creator? creator;
  String? title;
  String? description;
  List<Likes>? likes;
  int? totalLike;
  int? totalFollow;
  int? totalComment;
  String? createdAt;
  String? updatedAt;

  Threads(
      {this.sId,
      this.topic,
      this.creator,
      this.title,
      this.description,
      this.likes,
      this.totalLike,
      this.totalFollow,
      this.totalComment,
      this.createdAt,
      this.updatedAt});

  Threads.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    topic = json['topic'] != null ? new Topic.fromJson(json['topic']) : null;
    creator =
        json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    title = json['title'];
    description = json['description'];
    if (json['likes'] != null) {
      likes = <Likes>[];
      json['likes'].forEach((v) {
        likes!.add(new Likes.fromJson(v));
      });
    }
    totalLike = json['totalLike'];
    totalFollow = json['totalFollow'];
    totalComment = json['totalComment'];
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
    data['totalLike'] = this.totalLike;
    data['totalFollow'] = this.totalFollow;
    data['totalComment'] = this.totalComment;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Topic {
  String? sId;
  String? topic;
  String? description;
  String? createdAt;
  String? updatedAt;

  Topic(
      {this.sId, this.topic, this.description, this.createdAt, this.updatedAt});

  Topic.fromJson(Map<String, dynamic> json) {
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

class Creator {
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

  Creator(
      {this.sId,
      this.email,
      this.userName,
      this.displayName,
      this.biodata,
      this.socialMedia,
      this.isActive,
      this.role,
      this.createdAt,
      this.updatedAt});

  Creator.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Likes {
  Creator? user;
  String? timestamp;

  Likes({this.user, this.timestamp});

  Likes.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new Creator.fromJson(json['user']) : null;
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
