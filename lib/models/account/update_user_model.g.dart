// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserModel _$UpdateUserModelFromJson(Map<String, dynamic> json) =>
    UpdateUserModel(
      email: json['email'] as String?,
      userName: json['userName'] as String?,
      displayName: json['displayName'] as String?,
      biodata: json['biodata'] as String?,
      socialMedia: json['socialMedia'] as String?,
      profilePictureURL: json['profilePictureURL'] as String?,
    );

Map<String, dynamic> _$UpdateUserModelToJson(UpdateUserModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'userName': instance.userName,
      'displayName': instance.displayName,
      'biodata': instance.biodata,
      'socialMedia': instance.socialMedia,
      'profilePictureURL': instance.profilePictureURL,
    };
