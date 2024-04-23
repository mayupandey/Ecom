import 'package:dio/dio.dart';
import '../endpoints.dart';
import 'dio_interceptor.dart';

class DioClient {
  DioClient();

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: Endpoints.baseUrl,
      connectTimeout: const Duration(seconds: Endpoints.connectionTimeout),
      receiveTimeout: const Duration(seconds: Endpoints.receiveTimeout),
      responseType: ResponseType.json,
    ),
  )..interceptors.addAll([
      LoggerInterceptor(),
      // CurlLoggerDioInterceptor(
      //   printOnSuccess: true
      // ),
      // ///TODO: REMOVE BEFORE DEPLOYING
      // PrettyDioLogger(
      //     requestHeader: true,
      //     requestBody: true,
      //     responseBody: true,
      //     responseHeader: false,
      //     error: true,
      //     compact: true,
      //     maxWidth: 90),
      // DioFirebasePerformanceInterceptor()
    ]);

  void addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(interceptor);
  }
}
