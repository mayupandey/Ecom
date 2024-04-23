import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';




class LoggerInterceptor extends Interceptor {


  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';
log("Error API");
    return super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    // options.headers["Authorization"]=SharedStorage.instance.idToken;
    // options.headers["AccessToken"]=SharedStorage.instance.accessToken;
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {

    return super.onResponse(response, handler);
  }




}


class DioFirebasePerformanceInterceptor extends Interceptor {
  DioFirebasePerformanceInterceptor({
    this.requestContentLengthMethod = defaultRequestContentLength,
    this.responseContentLengthMethod = defaultResponseContentLength,
  });
  final RequestContentLengthMethod requestContentLengthMethod;
  final ResponseContentLengthMethod responseContentLengthMethod;
  static const extraKey = 'DioFirebasePerformanceInterceptor';

  @override
  Future onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {




    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response,
      ResponseInterceptorHandler handler,
      ) async {

    return super.onResponse(response, handler);
  }

  @override
  Future onError(
      DioError err,
      ErrorInterceptorHandler handler,
      ) async {

    return super.onError(err, handler);
  }

}

typedef RequestContentLengthMethod = int? Function(RequestOptions options);
int? defaultRequestContentLength(RequestOptions options) {
  try {
    return options.headers.toString().length + options.data.toString().length;
  } catch (_) {
    return null;
  }
}

typedef ResponseContentLengthMethod = int? Function(Response options);
int? defaultResponseContentLength(Response response) {
  try {
    String? lengthHeader = response.headers[Headers.contentLengthHeader]?.first;
    int length = int.parse(lengthHeader ?? '-1');
    if (length <= 0) {
      int headers = response.headers.toString().length;
      length = headers + response.data.toString().length;
    }
    return length;
  } catch (_) {
    return null;
  }
}



extension _UriHttpMethod on Uri {
  String normalized() {
    return "$scheme://$host$path";
  }
}

