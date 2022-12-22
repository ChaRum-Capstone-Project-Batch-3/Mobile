// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicResponse _$TopicResponseFromJson(Map<String, dynamic> json) =>
    TopicResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TopicResponseToJson(TopicResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'pagination': instance.pagination,
    };
