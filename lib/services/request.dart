import 'package:dio/dio.dart';

typedef OnSuccess = void Function(int? statusCode, String? response);
typedef OnFailure = void Function(int? statusCode, String? response);
typedef OnError = void Function();

class RequestClient {
  static RequestClient? _requestClinet;
  static Dio? _dio;
  static String _baseUrl = 'https://freecurrencyapi.net/';
  static int _timeout = 60000;

  RequestClient._createInstance();

  factory RequestClient() {
    if (_requestClinet == null) {
      _requestClinet = RequestClient._createInstance();
      _configDio();
    }
    return _requestClinet!;
  }

  static _configDio() {
    _dio = Dio();
    BaseOptions options = new BaseOptions(
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
      responseType: ResponseType.plain,
      queryParameters: {"apikey" : "8824aa30-7ea8-11ec-b0ac-37f5ef3b56ed"}
    );

    _dio!.options = options;
  }

  Future<void> get({
    required String endPoint,
    Map<String, String>? header,
    Map<String, dynamic>? queryParam,
    required OnSuccess onSuccess,
    required OnFailure onFailure,
    required OnError onError,
  }) async {
    _dio!.options.headers.clear();

    _dio!.options.baseUrl = _baseUrl;

    if (header != null) {
      _dio!.options.headers.addAll(header);
    }

    try {
      Response response = await _dio!.get(endPoint, queryParameters: queryParam);
      onSuccess(response.statusCode!, response.data.toString());
    } on DioError catch (e) {
      if (e.response != null) {
        onFailure(e.response!.statusCode, e.response!.data.toString());
      } else {
        onError();
      }
    } on Exception {
      onError();
    }
  }
}
