import 'package:dio/dio.dart';
import 'package:fgd_flutter/models/create_thread/create_thread.dart';
import 'package:fgd_flutter/models/create_thread/create_thread_response.dart';

import '../shared/api_utils.dart';

class CreadThreadApi extends ApiUtils {
  //make a post request to send create thread
  Future<CreateThreadResponse> createThread(String token, CreateThreadBody thread) async {
    var response = await ApiUtils().dio.post('/thread',
        options: Options(headers: {'Authorization': token}),
        data: thread.toJson());
    print(response.data.toString());
    return CreateThreadResponse.fromJson(response.data);
  }
}