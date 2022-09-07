import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:lesson_getx/model/post_model.dart';
import 'interceptor_service.dart';

class NetworkService {

  /// Base Url */
  static bool isTester = true;

  static String SERVER_DEVELOPMENT = "https://630ddfe9109c16b9abef55a6.mockapi.io";
  static String SERVER_PRODUCTION = "https://630ddfe9109c16b9abef55a6.mockapi.io";

  static String get baseApiUrl {
    if (isTester) return SERVER_DEVELOPMENT;
    return SERVER_PRODUCTION;
  }

  /// Apis */
  static String API_LIST = "/api/v1/posts";
  static String API_CREATE = "/api/v1/posts";
  static String API_UPDATE = "/api/v1/posts/"; // {ID}
  static String API_DELETE = "/api/v1/posts/"; // {ID}

  /// Headers */
  static Map<String, String> get headers {
    Map<String, String> headers = {
      'Accept': '*/*',
      'Content-Type': 'application/json',
      'Accept-Version': 'v1',
    };
    return headers;
  }

  static Map<String, String> get headersMultipart {
    Map<String, String> headers = {
      'Accept': '*/*',
      'Content-Type': 'multipart/form-data',
      'Accept-Version': 'v1',
    };
    return headers;
  }

  /// BaseOptions */
  static final BaseOptions _baseDioOptions = BaseOptions(
    baseUrl: baseApiUrl,
    headers: headers,
    connectTimeout: 40000,
    receiveTimeout: 40000,
    contentType: 'application/json',
    responseType: ResponseType.json,
  );

  static final BaseOptions _baseDioOptionsMultipart = BaseOptions(
    baseUrl: baseApiUrl,
    headers: headersMultipart,
    connectTimeout: 40000,
    receiveTimeout: 40000,
    contentType: 'multipart/form-data',
    responseType: ResponseType.bytes,
  );

  static final Dio _dio = Dio(_baseDioOptions)..interceptors.add(DioInterceptor());

  /* Dio Requests */
  static Future GET(String api, Map<String, dynamic> params) async {
    Response response = await _dio.get(api, queryParameters: params);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    }
    return null;
  }

  static Future POST(String api, Map<String, dynamic> body) async {
    Response response = await _dio.post(api, data: jsonEncode(body) );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    }
    return null;
  }

  static Future<String?> MULTIPART(String api, String path) async {
    _dio.options = _baseDioOptionsMultipart;
    Response response = await _dio.post(api, data: {
      "file" : await MultipartFile.fromFile(path, filename: "test")
    });
    _dio.options = _baseDioOptions;
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    }
    return null;
  }

  static Future<Map<String, dynamic>?> PUT(String api, Map<String, dynamic> params) async {
    Response response = await _dio.put(api, data: params); // http or https
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    }
    return null;
  }

  static Future<String?> PATCH(String api, Map<String, dynamic> params) async {
    Response response = await _dio.patch(api, data: params);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    }
    return null;
  }

  static Future<dynamic> DELETE(String api, Map<String, dynamic> params) async {
    Response response = await _dio.delete(api, data: params);
    if (response.statusCode == 200 || response.statusCode == 201||response.statusCode == 204) {
      return response.data;
    }
    return null;
  }


  /// Dio Query Params */
  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }


  /// Dio Body */
  static Map<String, dynamic> bodyCreate(Post post) {
    Map<String, dynamic> params = {};
    params.addAll({
      'title': post.title,
      'body': post.body,
      'userId': post.userId,
    });
    return params;
  }

  static Map<String, dynamic> bodyUpdate(Post post) {
    Map<String, dynamic> params = {};
    params.addAll({
      'id': post.id.toString(),
      'title': post.title,
      'body': post.body,
      'userId': post.userId,
    });
    return params;
  }

  /// Dio Parsing */
  static List<Post> parsePostList(List json) {
    var data = List<Post>.from(json.map((x) => Post.fromJson(x)));
    return data;
  }
}