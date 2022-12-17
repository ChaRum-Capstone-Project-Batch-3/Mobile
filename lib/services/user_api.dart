import 'package:dio/dio.dart';
import 'package:fgd_flutter/models/account/get_user_response.dart';
import 'package:fgd_flutter/models/account/update_user_response.dart';
import 'package:fgd_flutter/models/account/update_user_model.dart';

import '../shared/api_utils.dart';

class UserApi extends ApiUtils {
  Future<GetUserResponse> getUser(String token) async {
    var response = await ApiUtils().dio.get('/user/profile',
        options: Options(headers: {'Authorization': token}));
    GetUserResponse userRes = GetUserResponse.fromJson(response.data);
    print(response.data);
    return userRes;
  }

  Future<UpdateUserResponse> updateUser(
      String token, UpdateUserModel user) async {
    var response = await ApiUtils().dio.put('/user/profile',
        data: user.toJson(),
        options: Options(headers: {'Authorization': token}));
    UpdateUserResponse userRes = UpdateUserResponse.fromJson(response.data);
    print(response.data);
    return userRes;
  }
}
