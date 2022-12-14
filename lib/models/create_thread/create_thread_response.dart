class CreateThreadResponse {
  int? status;
  String? message;
  Data? data;

  CreateThreadResponse({this.status, this.message, this.data});

  CreateThreadResponse.fromJson(Map<String, dynamic> json) {
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
  String? field;
  String? message;

  Data({this.thread, this.field, this.message});

  Data.fromJson(Map<String, dynamic> json) {
    thread =
        json['thread'] != null ? new Thread.fromJson(json['thread']) : null;
    field = json['field'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.thread != null) {
      data['thread'] = this.thread!.toJson();
    }
    data['field'] = this.field;
    data['message'] = this.message;
    return data;
  }
}

class Thread {
  String? sId;
  Topic? topic;
  Creator? creator;
  String? title;
  String? description;
  String? imageURL;
  List<Likes>? likes;
  String? createdAt;
  String? updatedAt;

  Thread(
      {this.sId,
      this.topic,
      this.creator,
      this.title,
      this.description,
      this.imageURL,
      this.likes,
      this.createdAt,
      this.updatedAt});

  Thread.fromJson(Map<String, dynamic> json) {
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