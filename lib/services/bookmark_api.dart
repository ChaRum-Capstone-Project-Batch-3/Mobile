import 'package:dio/dio.dart';
import 'package:fgd_flutter/models/base_response.dart';
import 'package:fgd_flutter/models/bookmark/bookmark_response.dart';
import 'package:fgd_flutter/models/bookmark/like_thread_response.dart';
import 'package:fgd_flutter/shared/api_utils.dart';

class BookmarkApi extends ApiUtils {
  Future<BookmarkResponse> getBookmark(String token) async {
    BookmarkResponse result = BookmarkResponse();
    try {
      var response = await dio.get('/thread/bookmark',
          options: Options(headers: {"Authorization": token}));
      print(response.data.toString());
      result = BookmarkResponse.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      print(e.toString());
      return result;
    }
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

  Future<BaseResponse> followThread(String id, String token) async {
    var response = await dio.post('/thread/follow/$id',
        options: Options(headers: {"Authorization": token}));
    BaseResponse result = BaseResponse.fromJson(response.data);
    return result;
  }

  Future<BaseResponse> unfollowThread(String id, String token) async {
    var response = await dio.delete('/thread/follow/$id',
        options: Options(headers: {"Authorization": token}));
    BaseResponse result = BaseResponse.fromJson(response.data);
    return result;
  }

  Future<BaseResponse> bookmarkThread(String id, String token) async {
    var response = await dio.post("/thread/bookmark/$id",
        options: Options(headers: {"Authorization": token}));
    BaseResponse result = BaseResponse.fromJson(response.data);
    return result;
  }

  Future<BaseResponse> unbookmarkThread(String id, String token) async {
    var response = await dio.delete("/thread/bookmark/$id",
        options: Options(headers: {"Authorization": token}));
    print(response.data.toString());
    BaseResponse result = BaseResponse.fromJson(response.data);
    return result;
  }
}
