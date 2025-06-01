import 'package:dio/dio.dart';
import '../utils/constants/api_constants.dart';
import '../utils/constants/shared_preference_constants.dart';

class DioHelper {
  static final DioHelper _instance = DioHelper._internal();
  factory DioHelper() => _instance;
  DioHelper._internal() {
    _init();
  }

  late Dio dio;

  void _init() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        "Accept": "application/json",
      },
    );

    dio = Dio(options);

      // Add Interceptors
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {

          // Modify request if needed
          print("🚀 Sending request to: ${options.uri}");
          print(options.path);
          print("📌 Headers: ${options.headers}");
          return handler.next(options); // Continue with the request
        },
        onResponse: (response, handler) {
          // Log response
          print("✅ Response: ${response.statusCode} -> ${response.data}");
          return handler.next(response); // Continue with the response
        },
        onError: (DioException e, handler) async {
          print("❌ Error: ${e.response?.statusCode} -> ${e.message}");
          if (e.response?.statusCode == 401) {

            // print("🔄 Token expired, refreshing...");
            // // Attempt to refresh the token
            // await refreshToken(); // your custom refresh function
            //   final cloneReq = await dio.request(
            //     e.requestOptions.path,
            //     options: Options(
            //       method: e.requestOptions.method,
            //       headers: e.requestOptions.headers,
            //     ),
            //     data: e.requestOptions.data,
            //     queryParameters: e.requestOptions.queryParameters,
            //   );
            //   return handler.resolve(cloneReq);
          }

          return handler.next(e); // Continue error handling
        },
      ));
    }


  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
      return await dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
      return await dio.post(path, data: data, queryParameters: queryParameters);
  }

  Future<Response> put(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
      return await dio.put(path, data: data, queryParameters: queryParameters);
  }

  Future<Response> delete(String path, {Map<String, dynamic>? queryParameters}) async {
      return await dio.delete(path, queryParameters: queryParameters);
  }

}




