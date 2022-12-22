import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  String? parentID;
  String? comment;

  CommentModel({this.parentID, this.comment});

  CommentModel.fromJson(Map<String, dynamic> json) {
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
