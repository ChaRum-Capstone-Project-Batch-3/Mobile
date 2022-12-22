// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_thread_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetThreadDetailResponse _$GetThreadDetailResponseFromJson(
        Map<String, dynamic> json) =>
    GetThreadDetailResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetThreadDetailResponseToJson(
        GetThreadDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
