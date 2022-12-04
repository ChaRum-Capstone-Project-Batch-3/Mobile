import 'package:fgd_flutter/models/login.dart';
import 'package:fgd_flutter/models/login_response.dart';
import 'package:fgd_flutter/shared/api_utils.dart';

class LoginApi extends ApiUtils {
  Future<LoginResponse> login(Login login) async {
    var response =
        await ApiUtils().dio.post('/user/login', data: login.toJson());
    return LoginResponse.fromJson(response.data);
  }
}
