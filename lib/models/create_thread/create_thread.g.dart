// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_thread.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateThreadBody _$CreateThreadBodyFromJson(Map<String, dynamic> json) =>
    CreateThreadBody(
      topicID: json['topicID'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      imageURL: json['imageURL'] as String?,
    );

Map<String, dynamic> _$CreateThreadBodyToJson(CreateThreadBody instance) =>
    <String, dynamic>{
      'topicID': instance.topicID,
      'title': instance.title,
      'description': instance.description,
      'imageURL': instance.imageURL,
    };
