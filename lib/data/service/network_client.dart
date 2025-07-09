import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart';
import 'package:ui_design1/app.dart';
import 'package:ui_design1/ui/controller/auth_controller.dart';
import 'package:ui_design1/ui/screens/login_screen.dart';

class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final Map<String, dynamic>? data;
  final String errorMessage;

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
    final Map<String, String> headers = {'token' : AuthController.token ?? ''};
    try {
      Uri uri = Uri.parse(url);
      preRequestLogger(url, headers);
      Response response = await get(uri, headers: headers);
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
      }
      else if(response.statusCode==401){
        _moveToLoginScreen();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,

        );
      }
      else {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          data:  decodedJson,
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

  static Future<NetworkResponse> postRequest({
    required String url,
    required Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      final Map<String, String> headers = {'Content-type': 'Application/json' , 'token' : AuthController.token ?? ''};

      preRequestLogger(url,headers, body: body);
      Response response = await post(
        uri,
        headers: headers,
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
      }
      else if(response.statusCode==401){
        _moveToLoginScreen();
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,

        );
      }
      else {
        final decodedJson = jsonDecode(response.body);
        String? errorMessage = decodedJson["data"] ;
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: errorMessage ?? 'Something Went Wrong'
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

  static void preRequestLogger(String url,  Map<String,String> header, {Map<String, dynamic>? body}) {
    _logger.i(
      'URL : $url'
      'body : $body '
      'header : $header'
    );
  }

  static void postRequestLogger(String url,int statusCode, {Map<String, dynamic>? headers,dynamic body, String? errorMessage,}) {
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

  static void _moveToLoginScreen() async{
    await AuthController.clearUserInfo();
    Navigator.pushAndRemoveUntil(TaskManagerApp.navigatorKey.currentContext!, MaterialPageRoute(builder: (context)=>LoginScreen()), (predicate)=>false) ;
  }
}

