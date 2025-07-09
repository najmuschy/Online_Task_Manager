import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_design1/data/models/user_model.dart';

class AuthController{
  static String? token;
  static UserModel? userModel;

  static const String tokenKey = 'token' ;
  static const String userData = 'user-data' ;
  static Future<void> saveUserInfo(String accessToken, UserModel receivedUserModel) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(tokenKey, accessToken) ;
    sharedPreferences.setString(userData,jsonEncode(receivedUserModel.toJson()));

    token = accessToken;
    userModel =receivedUserModel ;
  }

  static Future<void> getUserInfo() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString(tokenKey) ;
    String? savedUserModelString = sharedPreferences.getString(userData) ;

    if(savedUserModelString!=null){
      UserModel savedUserModel = UserModel.fromJson(jsonDecode(savedUserModelString)) ;
      userModel = savedUserModel ;
    }

    token=accessToken ;

  }

  static Future<bool> confirmUserLoggedIn() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userAccessToken = sharedPreferences.getString(tokenKey);
    if(userAccessToken!= null){
      await getUserInfo() ;
      return true ;
    }
    return false ;
  }
  static Future<void> clearUserInfo() async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance() ;
    await sharedPreferences.clear() ;
    token = null ;
    userModel = null ;

  }
  }