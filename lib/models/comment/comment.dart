import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  String? parentID;
  String? comment;

  Comment({this.parentID, this.comment});

  Comment.fromJson(Map<String, dynamic> json) {
    parentID = json['parentID'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parentID'] = this.parentID;
    data['comment'] = this.comment;
    return data;
  }
}
