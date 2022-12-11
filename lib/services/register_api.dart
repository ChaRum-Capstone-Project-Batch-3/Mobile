import 'package:fgd_flutter/models/register/register.dart';
import 'package:fgd_flutter/models/register/register_response.dart';
import 'package:fgd_flutter/shared/api_utils.dart';

class RegisterApi extends ApiUtils {
  Future<RegisterResponse> register(Register register) async {
    var response =
        await ApiUtils().dio.post('/user/register', data: register.toJson());

    print(response.data.toString());
    var data = RegisterResponse.fromJson(response.data);

    return data;
  }
}
