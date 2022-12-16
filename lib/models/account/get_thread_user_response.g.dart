// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_thread_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetThreadUserResponse _$GetThreadUserResponseFromJson(
        Map<String, dynamic> json) =>
    GetThreadUserResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetThreadUserResponseToJson(
        GetThreadUserResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
