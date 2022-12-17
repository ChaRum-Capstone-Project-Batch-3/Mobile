// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookmarkResponse _$BookmarkResponseFromJson(Map<String, dynamic> json) =>
    BookmarkResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookmarkResponseToJson(BookmarkResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
