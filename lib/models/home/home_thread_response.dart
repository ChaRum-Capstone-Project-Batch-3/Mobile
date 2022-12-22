import 'package:json_annotation/json_annotation.dart';

part 'home_thread_response.g.dart';

@JsonSerializable()

class HomeThreadResponse {
  int? status;
  String? message;
  Data? data;
  Pagination? pagination;

  HomeThreadResponse({this.status, this.message, this.data, this.pagination});

  HomeThreadResponse.fromJson(Map<String, dynamic> json) {
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
  int? totalPage;
  List<Threads>? threads;

  Data({this.totalPage, this.threads});

  Data.fromJson(Map<String, dynamic> json) {
    totalPage = json['totalPage'];
    if (json['threads'] != null) {
      threads = <Threads>[];
      json['threads'].forEach((v) {
        threads!.add(new Threads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalPage'] = this.totalPage;
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
  String? imageURL;
  List<Likes>? likes;
  String? createdAt;
  String? updatedAt;

  Threads(
      {this.sId,
      this.topic,
      this.creator,
      this.title,
      this.description,
      this.imageURL,
      this.likes,
      this.createdAt,
      this.updatedAt});

  Threads.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    topic = json['topic'] != null ? new Topic.fromJson(json['topic']) : null;
    creator =
        json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    title = json['title'];
    description = json['description'];
    imageURL = json['imageURL'];
    if (json['likes'] != null) {
      likes = <Likes>[];
      json['likes'].forEach((v) {
        likes!.add(new Likes.fromJson(v));
      });
    }
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
    data['imageURL'] = this.imageURL;
    if (this.likes != null) {
      data['likes'] = this.likes!.map((v) => v.toJson()).toList();
    }
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

class Creator {
  String? sId;
  String? email;
  String? userName;
  String? displayName;
  bool? isActive;
  String? role;
  String? createdAt;
  String? updatedAt;

  Creator(
      {this.sId,
      this.email,
      this.userName,
      this.displayName,
      this.isActive,
      this.role,
      this.createdAt,
      this.updatedAt});

  Creator.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    userName = json['userName'];
    displayName = json['displayName'];
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
    data['isActive'] = this.isActive;
    data['role'] = this.role;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Likes {
  Creator? user;
  String? createdAt;

  Likes({this.user, this.createdAt});

  Likes.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new Creator.fromJson(json['user']) : null;
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class Pagination {
  int? size;
  int? totalData;
  int? totalPage;
  int? currentPage;

  Pagination({this.size, this.totalData, this.totalPage, this.currentPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    totalData = json['totalData'];
    totalPage = json['totalPage'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['totalData'] = this.totalData;
    data['totalPage'] = this.totalPage;
    data['currentPage'] = this.currentPage;
    return data;
  }
}