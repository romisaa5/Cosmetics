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
              "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI1MTY4IiwidW5pcXVlX25hbWUiOiJyb21pc2FhMTIzIiwiZW1haWwiOiJyb21pc2FhZmFkZWw5ODJAZ21haWwuY29tIiwicm9sZSI6IkN1c3RvbWVyIiwibmJmIjoxNzczMjE3OTU0LCJleHAiOjE3NzMzMDQzNTQsImlhdCI6MTc3MzIxNzk1NCwiaXNzIjoiQ29zbWF0aWNzQXBpIiwiYXVkIjoiQ29zbWF0aWNzVXNlcnMifQ.TQn5PWjdvZSN6DxYpqS0hb0VzzvZ2XlFZFKoY4neotXlVlR2VdDkBxaBVoMuhow6EgCUz7pUrP0PqRorYmT9_g";
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
