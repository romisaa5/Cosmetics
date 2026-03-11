import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory();

  Future<Dio> createDio() async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://cosmatics.growfet.com',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        responseType: ResponseType.json,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          String token = "your_token_here";
          options.headers["Authorization"] = "Bearer $token";
          return handler.next(options);
        },
      ),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: true,
      ),
    );

    return dio;
  }
}
