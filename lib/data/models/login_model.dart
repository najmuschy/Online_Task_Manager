import 'package:ui_design1/data/models/user_model.dart';

class LoginModel{
  late final status;
  late final token;
  late UserModel userModel ;

  LoginModel.fromJson(Map<String,dynamic> jsonData){
    token = jsonData['token']?? '';
    status = jsonData['status']?? '';
    userModel = UserModel.fromJson(jsonData['data']?? {});
  }

}