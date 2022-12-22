// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'followed_thread_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowedThreadResponse _$FollowedThreadResponseFromJson(
        Map<String, dynamic> json) =>
    FollowedThreadResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FollowedThreadResponseToJson(
        FollowedThreadResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
