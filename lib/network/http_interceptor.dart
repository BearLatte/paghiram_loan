import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    HttpException httpException = HttpException.create(err);
    if (err.type == DioExceptionType.unknown) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        httpException = HttpException(code: -100, msg: 'None Network');
      }
    }

    err.copyWith(error: httpException);
    super.onError(err, handler);
  }
}

class HttpException implements Exception {
  final int code;
  final String msg;

  HttpException({this.code = -1, this.msg = 'unknown error'});

  @override
  String toString() {
    return 'Http Error [$code]: $msg';
  }

  factory HttpException.create(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return HttpException(code: -1, msg: 'The server connection timed out, please try again later.');
      case DioExceptionType.sendTimeout:
        return HttpException(code: -1, msg: 'The request send timeout.');
      case DioExceptionType.receiveTimeout:
        return HttpException(code: -1, msg: 'The response received timeout.');
      case DioExceptionType.cancel:
        return HttpException(code: -1, msg: 'The request is cancelled.');
      case DioExceptionType.connectionError:
        return HttpException(code: -1, msg: 'Network connection failed, please switch network and try again.');
      case DioExceptionType.unknown:
        return HttpException(code: -1, msg: 'Unknown error');
      case DioExceptionType.badResponse:
        return _createExceptionWithCode(error: error);
      default:
        return HttpException(code: -1, msg: error.message ?? '');
    }
  }

  static HttpException _createExceptionWithCode({required DioException error}) {
    var statusCode = error.response?.statusCode ?? 0;
    try {
      switch (statusCode) {
        default:
          return HttpException(code: statusCode, msg: error.response?.statusMessage ?? 'unknown error');
      }
    } on Exception catch (_) {
      return HttpException(code: -1, msg: 'unknown error');
    }
  }
}
