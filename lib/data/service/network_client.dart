import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:http/http.dart';

class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final Map<String, dynamic>? data;
  final String? errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.data,
    this.errorMessage = 'Something went wrong',
  });
}

class NetworkClient {
  static final Logger _logger = Logger();
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      preRequestLogger(url);
      Response response = await get(uri);
      postRequestLogger(
        url,
        response.statusCode,
        headers: response.headers,
        body: response.body,
      );
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          data: decodedJson,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      _logger.e(e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest({
    required String url,
    required Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      preRequestLogger(url, body: body);
      Response response = await post(
        uri,
        headers: {'Content-type': 'Application/json'},
        body: jsonEncode(body),
      );
      postRequestLogger(
        url,
        response.statusCode,
        headers: response.headers,
        body: response.body,
      );

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          data: decodedJson,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      postRequestLogger(url, -1, errorMessage: e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static void preRequestLogger(String url, {Map<String, dynamic>? body}) {
    _logger.i(
      'URL : $url'
      'body : $body ',
    );
  }

  static void postRequestLogger(
    String url,
    int statusCode, {
    Map<String, dynamic>? headers,
    dynamic body,
    String? errorMessage,
  }) {
    if (errorMessage != null) {
      _logger.e(
        'Status Code : $statusCode \n'
        'error : $errorMessage',
      );
    } else {
      _logger.i(
        'Status Code : $statusCode \n'
        'Headers : $headers \n'
        'Response : $body \n',
      );
    }
  }
}
