// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_topics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTopics _$GetTopicsFromJson(Map<String, dynamic> json) => GetTopics(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetTopicsToJson(GetTopics instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'pagination': instance.pagination,
    };
