import 'package:dio/dio.dart';
import 'package:fgd_flutter/models/account/get_user_response.dart';
import 'package:fgd_flutter/models/account/update_user_response.dart';
import 'package:fgd_flutter/models/account/update_user_model.dart';

import '../models/account/get_thread_user_response.dart';
import '../models/base_response.dart';
import '../models/bookmark/like_thread_response.dart';
import '../shared/api_utils.dart';

class UserApi extends ApiUtils {
  Future<GetUserResponse> getUser(String token) async {
    var response = await ApiUtils().dio.get('/user/profile',
        options: Options(headers: {'Authorization': token}));
    GetUserResponse userRes = GetUserResponse.fromJson(response.data);
    print(response.data);
    return userRes;
  }

  Future<GetThreadUserResponse> getThreadUser(String token) async {
    var response = await ApiUtils()
        .dio
        .get('/thread', options: Options(headers: {'Authorization': token}));
    GetThreadUserResponse userRes =
        GetThreadUserResponse.fromJson(response.data);
    return userRes;
  }

  Future<BaseResponse> deleteThreadUser(
      String id, String token) async {
    var response = await ApiUtils().dio.delete('/thread/id/$id',
        options: Options(headers: {'Authorization': token}));
    BaseResponse userRes =
        BaseResponse.fromJson(response.data);
    print('delete thread ' + response.data.toString());
    return userRes;
  }

  Future<UpdateUserResponse> updateUser(
      String token, UpdateUserModel user) async {
    print('profileUrl :' + user.profilePictureURL!);
    FormData formValidation = FormData.fromMap({
      "email": user.email,
      "userName": user.userName,
      "biodata": user.biodata,
      "displayName": user.displayName,
      "socialMedia": user.socialMedia,
      "profilePicture": user.profilePictureURL != ''
          ? await MultipartFile.fromFile(user.profilePictureURL!)
          : null,
    });
    var response = await ApiUtils().dio.put('/user/profile',
        data: formValidation,
        options: Options(headers: {
          'Authorization': token,
          'Content-Type': 'multipart/form-data'
        }));
    UpdateUserResponse userRes = UpdateUserResponse.fromJson(response.data);
    print(response.data);
    return userRes;
  }

  Future<LikeThreadResponse> likeThread(String id, String token) async {
    var response = await dio.post('/thread/like/id/$id',
        options: Options(headers: {"Authorization": token}));
    LikeThreadResponse result = LikeThreadResponse.fromJson(response.data);
    print("like" + response.data.toString());
    return result;
  }

  Future<LikeThreadResponse> unlikeThread(String id, String token) async {
    var response = await dio.delete('/thread/like/id/$id',
        options: Options(headers: {"Authorization": token}));
    LikeThreadResponse result = LikeThreadResponse.fromJson(response.data);
    print("unlike" + response.data.toString());
    return result;
  }
}
