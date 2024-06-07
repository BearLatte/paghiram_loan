import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:paghiram_loan/common/common_snack_bar.dart';
import 'package:paghiram_loan/network/http_options.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:paghiram_loan/network/http_interceptor.dart';

class HttpRequest {
  static final HttpRequest _instance = HttpRequest._internal();

  factory HttpRequest() => _instance;
  static late final Dio dio;

  HttpRequest._internal() {
    BaseOptions options = BaseOptions(
        baseUrl: HttpOptions.instance.baseUrl,
        connectTimeout: Duration(milliseconds: HttpOptions.instance.connectTimeout),
        receiveTimeout: Duration(milliseconds: HttpOptions.instance.receiveTimeout),
        sendTimeout: Duration(milliseconds: HttpOptions.instance.sendTimeout),
        headers: HttpOptions.instance.headers);

    dio = Dio(options);
    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
      client.badCertificateCallback = (cert, host, port) {
        return true;
      };

      client.findProxy = (uri) {
        return 'PROXY 192.168.0.26:8888';
      };
      return null;
    };
    dio.interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true, responseHeader: true, responseBody: true));
  }

  Future<dynamic> request({
    required String path,
    required HttpMethod method,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool showLoading = true,
    bool showErrorMessage = true,
  }) async {
    const Map methodValues = {
      HttpMethod.get: 'get',
      HttpMethod.post: 'post',
      HttpMethod.delete: 'delete',
      HttpMethod.put: 'put',
      HttpMethod.patch: 'patch',
      HttpMethod.head: 'head'
    };

    Map<String, dynamic> headers = HttpOptions.instance.headers;

    Options options = Options(method: methodValues[method], headers: headers);

    try {
      if (showLoading) {
        EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.clear);
      }
      Response response = await HttpRequest.dio.request(path, data: FormData.fromMap(data ?? {}), queryParameters: queryParameters, options: options);
      return response.data;
    } on DioException catch (error) {
      HttpException httpException = HttpException.create(error);
      if (showErrorMessage) {
        CommonSnackBar.showSnackBar(httpException.msg, title: 'Network Error', type: SnackType.error);
      }
    } finally {
      if (showLoading) {
        EasyLoading.dismiss();
      }
    }
  }
}

enum HttpMethod { get, post, delete, put, patch, head }
