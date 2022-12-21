// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_thread_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateThreadResponse _$CreateThreadResponseFromJson(
        Map<String, dynamic> json) =>
    CreateThreadResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateThreadResponseToJson(
        CreateThreadResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
