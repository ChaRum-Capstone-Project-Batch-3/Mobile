// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_thread_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikeThreadResponse _$LikeThreadResponseFromJson(Map<String, dynamic> json) =>
    LikeThreadResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$LikeThreadResponseToJson(LikeThreadResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
