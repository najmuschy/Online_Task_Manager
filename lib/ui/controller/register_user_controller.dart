import 'package:get/get.dart' ;

import '../../data/service/network_client.dart';
import '../../data/utils/urls.dart';

class RegisterUserController extends GetxController{
  bool _registrationInProgress = false ;
  bool get registerInProgress => _registrationInProgress ;

  String? _errorMessage ;
  String get errorMessage => _errorMessage!;

  Future<bool>  registerUser(String email, String firstName, String lastName,String mobile, String password ) async{
    bool isSuccess = false ;
    _registrationInProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password
    };
    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.registerUrl,
      body: requestBody,
    );
    _registrationInProgress = false;
    update();
    if (response.isSuccess) {
      isSuccess = true ;

    } else {
      _errorMessage = response.errorMessage ;
    }

    return isSuccess ;
  }
}