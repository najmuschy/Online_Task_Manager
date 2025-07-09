import 'package:flutter/material.dart';
import 'package:ui_design1/data/models/user_model.dart';
import 'package:ui_design1/ui/controller/auth_controller.dart';

import 'package:email_validator/email_validator.dart';
import 'package:ui_design1/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:ui_design1/ui/widgets/screen_background.dart';
import 'package:ui_design1/ui/widgets/tm_appbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import '../../data/service/network_client.dart';
import '../../data/utils/urls.dart';
import '../widgets/scaffold_message.dart';


class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {


  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>() ;
  final ImagePicker _imagePicker = ImagePicker();
  bool _updateInProgress =  false ;
  XFile? _pickedImage ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(fromUpdateProfileScreen: true,),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 80),
                    Text(
                      'Update Profile',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    SizedBox(height: 25),
                    buildPhotoSelector(),
                    SizedBox(height: 8),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailTEController,
                      enabled: false,
                      decoration: InputDecoration(hintText: 'Email'),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _firstNameTEController,
                      decoration: InputDecoration(hintText: 'First Name'),
                      validator: (String? value){
                        if(value?.trim().isEmpty ?? true){
                          return 'Why exactly did you come here??' ;
                        }
                        return null ;
                      },
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _lastNameTEController,
                      decoration: InputDecoration(hintText: 'Last Name'),
                      validator: (String? value){
                        if(value?.trim().isEmpty ?? true){
                          return 'No last name?? Really?? Make one up' ;
                        }
                        return null ;
                      },
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      controller: _mobileTEController,
                      decoration: InputDecoration(hintText: 'Mobile'),
                      validator: (String? value){
                        String mobile = value?.trim() ?? '' ;
                        RegExp regExp = RegExp(r'^(?:\+88|88)?01[3-9]\d{8}$') ;
                        if(regExp.hasMatch(mobile)){
                          return null;
                        }
                        else{
                          return "CHECK YOO NUMBER FOOL! CAUSE THIS AIN'T THE RIGHT ONE";
                        }
                      },
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordTEController,
                      decoration: InputDecoration(hintText: 'Password of 6 character'),
                      validator: (String? value){
                        if(value!=null && value.isNotEmpty && value.length<6){
                          return "YOUR FINGERS GET OFF?? 6 CHARACTERS ISN'T ROCKET SCIENCE";
                        }
                        else{
                          return null ;
                        }

                      },
                    ),
                    SizedBox(height: 8),

                    Visibility(
                      visible: _updateInProgress ==false,
                      replacement: CenteredCircularProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: _onTapSubmitButton,
                        child: Icon(Icons.arrow_forward),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPhotoSelector() {
    return GestureDetector(
                onTap: _onTapPhotoPicker,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  child: Row(
                    children: [
                      Container(

                        width: 75,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade500,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5) )
                        ),
                        child: Center(child: Text('Photo', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)),
                      ),
                      const SizedBox(width: 8,),
                      Container(

                        child: Text(_pickedImage?.name ?? 'Select a photo', textAlign: TextAlign.center,),
                      )
                    ],
                  ),
                ),
              );
  }

  Future<void> _updateUser() async {
    _updateInProgress = true ;
    setState(() {});
    Map<String, dynamic> requestBody = {

      "email":_emailTEController.text.trim(),
      "firstName":_firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile":_mobileTEController.text.trim(),
    };
    if(_passwordTEController.text.isNotEmpty){
      requestBody['password']= _passwordTEController.text ;
    }

    NetworkResponse response = await NetworkClient.postRequest(url: Urls.updateProfile, body: requestBody) ;

    if(response.isSuccess) {


      _passwordTEController.clear() ;
      showScaffoldMessage(context, 'User data updated Successfully') ;

    }
    else{
      showScaffoldMessage(context, response.errorMessage, true) ;
    }
    _updateInProgress = false ;
    setState(() {});
  }


  void _onTapSubmitButton() {

    if (_formKey.currentState!.validate()) {
      _updateUser();
    }


  }
  void _onTapPhotoPicker() async{
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery) ;
    if(image!=null){
      _pickedImage = image ;
      setState(() {});
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserModel userModel = AuthController.userModel! ;
    _emailTEController.text = userModel.email;
    _firstNameTEController.text = userModel.firstName;
    _lastNameTEController.text = userModel.lastName;
    _mobileTEController.text = userModel.mobile;

  }
  @override
  void dispose() {
    // TODO: implement dispose
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();

  }
}
