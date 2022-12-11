// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Register _$RegisterFromJson(Map<String, dynamic> json) => Register(
      email: json['email'] as String?,
      userName: json['userName'] as String?,
      displayName: json['displayName'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$RegisterToJson(Register instance) => <String, dynamic>{
      'email': instance.email,
      'userName': instance.userName,
      'displayName': instance.displayName,
      'password': instance.password,
    };
