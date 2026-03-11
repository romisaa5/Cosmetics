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
          String token =
              "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI1MTY4IiwidW5pcXVlX25hbWUiOiJSb21pc2FhIiwiZW1haWwiOiJyb21pc2FhZmFkZWw5ODJAZ21haWwuY29tIiwicm9sZSI6IkN1c3RvbWVyIiwibmJmIjoxNzczMjAwNDE1LCJleHAiOjE3NzMyODY4MTUsImlhdCI6MTc3MzIwMDQxNSwiaXNzIjoiQ29zbWF0aWNzQXBpIiwiYXVkIjoiQ29zbWF0aWNzVXNlcnMifQ.A1U6UPlzPv3j3KKxr0LhFy0-OEP9UvnJ_cHTyJNfDWKCAdgyTTZ7UmxIKzZt3N_pkHWsrG8xHhr38pTWQBWjpQ";
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
