import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fgd_flutter/models/thread_detail/get_thread_detail_response.dart';
import 'package:fgd_flutter/shared/api_utils.dart';
import 'package:fgd_flutter/shared/local_storage.dart';

class ThreadDetailApi extends ApiUtils {
  Future<GetThreadDetailResponse?> getThread(
      String threadId, String token) async {
    try {
      Response response = await ApiUtils().dio.get("/thread/id/$threadId",
          options: Options(headers: {"Authorization": token}));
      print(response.data.toString());
      GetThreadDetailResponse result =
          GetThreadDetailResponse.fromJson(response.data);
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
