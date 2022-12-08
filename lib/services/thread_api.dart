import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fgd_flutter/models/thread_response.dart';
import 'package:fgd_flutter/shared/api_utils.dart';
import 'package:fgd_flutter/shared/local_storage.dart';

class ThreadApi extends ApiUtils {
  Future<ThreadResponse?> search(String sort, String order, String topic,
      String title, String token) async {
    try {
      Response response = await ApiUtils().dio.get("/thread/1",
          queryParameters: {
            "limit": 100,
            "sort": sort,
            "order": order,
            "topic-id": topic,
            "title": title
          },
          options: Options(headers: {"Authorization": token}));
      print(response.data.toString());
      ThreadResponse result = ThreadResponse.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.type == DioErrorType.other && e.error is SocketException) {
        print("Token not revoked");
      } else {
        rethrow;
      }
    }
  }
}
