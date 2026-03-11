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
              "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI1MTY4IiwidW5pcXVlX25hbWUiOiJSb21pc2FhIiwiZW1haWwiOiJyb21pc2FhZmFkZWw5ODJAZ21haWwuY29tIiwicm9sZSI6IkN1c3RvbWVyIiwibmJmIjoxNzczMjAwOTQ2LCJleHAiOjE3NzMyODczNDYsImlhdCI6MTc3MzIwMDk0NiwiaXNzIjoiQ29zbWF0aWNzQXBpIiwiYXVkIjoiQ29zbWF0aWNzVXNlcnMifQ.g4EC78ekv2jIr3Oha-gQRGOKH0TFDR5i5Zf9SgR3rNiZorZAiv8qb8f84QkcX6XolmnOATf6PO0QOTXicqT75w";
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
