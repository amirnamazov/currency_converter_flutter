import 'package:currency_converter/utils/locator.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef OnSuccess = void Function(int? statusCode, String? response);
typedef OnFailure = void Function(int? statusCode, String? response);
typedef OnError = void Function();

class RequestClient {
  static SharedPreferences _sharedPreferences = locator.get();
  static RequestClient? _requestClinet;
  static Dio? _dio;
  static String _baseUrlV1 = 'https://dev.starex.az/api/v1/';
  static String _baseUrlV2 = 'https://dev.starex.az/api/v2/';
  static String fileUrl = "https://dev.starex.az";
  static int _timeout = 60000;

  static List excludeToken = [
    '/api/v1/auth/login/',
    "/api/v1/auth/reset-password/",
    '/api/v1/fcm-device/sign_in/',
    '/api/v1/phone-prefixes/',
    '/api/v1/fcm-device/remove/',
    '/api/v1/warehouses',
    '/api/v1/auth/sign_in/',
  ];

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
    );

    _dio!.options = options;

    _dio!.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return _requestInterceptor(options, handler);
      },
      onResponse: (response, handler) {
        return _responseInterceptor(response, handler);
      },
      onError: (e, handler) {
        return _errorInterceptor(e, handler);
      },
    ));
  }

  Future<void> get({
    bool isV2 = false,
    required String endPoint,
    Map<String, String>? header,
    Map<String, dynamic>? queryParam,
    required OnSuccess onSuccess,
    required OnFailure onFailure,
    required OnError onError,
  }) async {
    _dio!.options.headers.clear();

    _dio!.options.baseUrl = isV2 ? _baseUrlV2 : _baseUrlV1;

    if (header != null) {
      _dio!.options.headers.addAll(header);
    }

    try {
      Response response =
          await _dio!.get(endPoint, queryParameters: queryParam);
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

  /*Future<void> post({
    bool isV2 = false,
    required String endPoint,
    required EReqMethod method,
    Map<String, String>? header,
    dynamic body,
    required OnSuccess onSuccess,
    required OnFailure onFailure,
    required OnError onError,
  }) async {
    try {
      _dio!.options.headers.clear();
      if (header != null) {
        _dio!.options.headers.addAll(header);
      }
      _dio!.options.baseUrl = isV2 ? _baseUrlV2 : _baseUrlV1;

      Response response;

      switch (method) {
        case EReqMethod.Put:
          response = await _dio!.put(endPoint, data: body);
          break;
        case EReqMethod.Post:
          response = await _dio!.post(endPoint, data: body);
          break;
        case EReqMethod.Patch:
          response = await _dio!.patch(endPoint, data: body);
          break;
        case EReqMethod.Delete:
          response = await _dio!.delete(endPoint, data: body);
          break;
      }

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        onSuccess(response.statusCode, response.data.toString());
      } else {
        onFailure(response.statusCode, response.data.toString());
      }
    } on DioError catch (e) {
      if (e.response != null) {
        onFailure(e.response!.statusCode, e.response!.data.toString());
      } else {
        onError();
      }
    } on Exception {
      onError();
    }
  }*/

  static dynamic _requestInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll(
      {'Content-Type': 'application/json; charset=UTF-8'},
    );

    //add token
    bool exclude = false;
    for (var item in excludeToken) {
      if (options.uri.path == item) {
        exclude = true;
        break;
      }
    }

    // if (exclude == false) {
    //   options.headers.addAll(
    //     {'Authorization': 'Token ${_sharedPreferences.getString(kToken)}'},
    //   );
    // }

    return handler.next(options);
  }

  static dynamic _responseInterceptor(
      Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  static dynamic _errorInterceptor(
      DioError e, ErrorInterceptorHandler handler) {
    if (e.response!.statusCode == 403 &&
        e.response!.data.toString().contains('token')) {
      _sharedPreferences.clear();
      Future.delayed(Duration(microseconds: 500)).then((value) {
        // navigatorKey.currentState?.pushAndRemoveUntil(
        //   SlideRightRoute(page: StartPage()),
        //   (route) => false,
        // );
      });
    }
    return handler.next(e);
  }
}
