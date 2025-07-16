import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/service/network_client.dart';
import '../../data/utils/urls.dart';
import 'auth_controller.dart';

class ProfileUpdateController extends GetxController{
  bool _profileUpdateInProgress = false ;
  String? _appBarEmail ;
  String? _appBarFirstName ;
  String? _appBarLastName ;
  String? _appBarPhoto ;
  bool get profileUpdateInProgress => _profileUpdateInProgress ;
  String? _errorMessage ;
  String? get errorMessage =>  _errorMessage ;
  String? get appBarEmail =>  _appBarEmail ;
  String? get appBarFullName {
    if(_appBarFirstName!=null && _appBarLastName!=null){
      return '$_appBarFirstName $_appBarLastName' ;
    }
    else{
      return null ;
    }
  }
  String? get appBarPhoto {
    if (_appBarPhoto != null) {
      return _appBarPhoto;
    }
    else {
      return null;
    }
  }
  Future<bool> profileUpdate(String email, String firstName, String lastName, String mobile, String? password, XFile? photo) async{
    _profileUpdateInProgress = true ;
    update() ;

    bool isSuccess= false ;
    String? tempPhoto ;
    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };

    if (password!=null && password.isNotEmpty) {
      requestBody["password"] = password;
    }

    if (photo != null) {
      List<int> imageBytes = await photo.readAsBytes();
      String encodedImage = base64Encode(imageBytes);
      tempPhoto= encodedImage;
      requestBody['photo'] = encodedImage;
    }

    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.updateProfileUrl,
      body: requestBody,
    );
    if(response.isSuccess){
      _appBarFirstName =firstName ;
      _appBarLastName = lastName ;
      _appBarEmail = email ;
      _appBarPhoto = tempPhoto ;

      isSuccess =true ;
    }
    else{
      _errorMessage =response.errorMessage ;
    }
    _profileUpdateInProgress =false ;
    update() ;
    return isSuccess ;
  }
}