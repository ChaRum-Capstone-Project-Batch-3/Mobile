import 'package:dio/dio.dart';
import 'package:fgd_flutter/models/account/get_user_response.dart';
import 'package:fgd_flutter/models/account/update_user_response.dart';

import '../shared/api_utils.dart';

class CreadThreadApi extends ApiUtils {
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

  //make a post request to send create thread
  Future<void> createThread(String token, String title, String content, String topicId) async {
    var response = await ApiUtils().dio.post('/thread',
        options: Options(headers: {'Authorization': token}),
        data: {
          "title": title,
          "content": content,
          "topic-id": topicId
        });
    print(response.data.toString());
  }
}
