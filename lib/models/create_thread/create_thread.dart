import 'package:json_annotation/json_annotation.dart';
part 'create_thread.g.dart';

@JsonSerializable()

class CreateThreadBody {
  String? topicID;
  String? title;
  String? description;
  String? imageURL;

  CreateThreadBody({this.topicID, this.title, this.description, this.imageURL});

  CreateThreadBody.fromJson(Map<String, dynamic> json) {
    topicID = json['topicID'];
    title = json['title'];
    description = json['description'];
    imageURL = json['imageURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topicID'] = this.topicID;
    data['title'] = this.title;
    data['description'] = this.description;
    data['imageURL'] = this.imageURL;
    return data;
  }
}