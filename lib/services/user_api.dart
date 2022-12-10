import 'package:dio/dio.dart';
import 'package:fgd_flutter/models/get_user_response.dart';
import 'package:fgd_flutter/models/update_user_response.dart';

import '../shared/api_utils.dart';

class UserApi extends ApiUtils {
  Future<GetUserResponse> getUser(String token) async {
    var response = await ApiUtils().dio.get('/user/profile',
        options: Options(headers: {'Authorization': token}));
    GetUserResponse userRes = GetUserResponse.fromJson(response.data);
    return userRes;
  }
  Future<UpdateUserResponse> updateUser(String token) async {
    var response = await ApiUtils().dio.put('/user/profile',
        options: Options(headers: {'Authorization': token}));
    UpdateUserResponse userRes = UpdateUserResponse.fromJson(response.data);
    return userRes;
  }

}
