import 'package:fgd_flutter/models/user.dart';
import 'package:fgd_flutter/models/user_response.dart';
import 'package:fgd_flutter/shared/api_utils.dart';

class LoginApi extends ApiUtils {
  Future<UserResponse> user(Users user) async {
    var response =
        await ApiUtils().dio.get('/user/profile', queryParameters: user.toJson());
    return UserResponse.fromJson(response.data);
  }
}