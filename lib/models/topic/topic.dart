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
