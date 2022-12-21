// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_detail_topics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

getDetailTopics _$getDetailTopicsFromJson(Map<String, dynamic> json) =>
    getDetailTopics(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$getDetailTopicsToJson(getDetailTopics instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
