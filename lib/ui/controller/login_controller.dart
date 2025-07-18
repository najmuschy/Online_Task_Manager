import 'package:get/get.dart';
import 'package:task_manager/data/models/login_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';


class LoginController extends GetxController{

  bool _loginInProgress = false ;
  bool get loginInProgress => _loginInProgress ;
  String? _errorMessage ;
  String get errorMessage => _errorMessage! ;
  Future<bool> login(String email, String password) async{
    bool isSuccess = false;
    _loginInProgress=true;
    update() ;
    Map<String, dynamic> loginBody = {"email" : email, "password" : password} ;
    NetworkResponse response =  await NetworkClient.postRequest(url : Urls.loginUrl, body: loginBody);

    if(response.isSuccess){
      LoginModel loginModel = LoginModel.fromJson(response.data!) ;
      await AuthController.saveUserInfo(loginModel.token, loginModel.userModel);
      isSuccess=true ;
      _errorMessage = null ;
    }
    else{
      _errorMessage = response.errorMessage ;
    }
    _loginInProgress = false ;
    update();
    return isSuccess ;

  }

}