import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ui_design1/data/service/network_client.dart';
import 'package:ui_design1/data/utils/urls.dart';
import 'package:ui_design1/ui/screens/login_screen.dart';
import 'package:ui_design1/ui/widgets/scaffold_message.dart';

import 'package:ui_design1/ui/widgets/screen_background.dart';
import 'package:email_validator/email_validator.dart';
import '../utils/assets_path.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool registrationInProgress = false ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80),
                  Text(
                    'Join With Us',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTEController,
                    decoration: InputDecoration(hintText: 'Email'),
                    validator: (String? value) {
                      String email = value?.trim() ?? "";
                      if (EmailValidator.validate(email) == false) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 6),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _firstNameTEController,
                    decoration: InputDecoration(hintText: 'First Name'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter a value';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 6),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _lastNameTEController,
                    decoration: InputDecoration(hintText: 'Last Name'),

                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter a last name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 6),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    controller: _mobileTEController,
                    decoration: InputDecoration(hintText: 'Mobile'),
                    validator: (String? value) {
                      String phone = value?.trim() ?? '';
                      RegExp regExp = RegExp(r'^(?:\+88|88)?01[3-9]\d{8}$');
                      if (regExp.hasMatch(phone)) {
                        return null;
                      }
                      return 'Enter a valid number';
                    },
                  ),
                  SizedBox(height: 6),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordTEController,
                    decoration: InputDecoration(hintText: 'Password'),

                    validator: (String? value) {
                      if ((value?.trim().isEmpty ?? true)|| (value!.length < 6)) {
                        return 'Enter a  valid password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  Visibility(

                    visible: registrationInProgress==false ,
                    replacement: Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                      onPressed: _onTapSubmitButton,
                      child: Icon(Icons.arrow_forward),
                    ),
                  ),
                  SizedBox(height: 32),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(text: "Already have an account?"),
                              TextSpan(
                                text: "Sign In",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = _onTapSignInButton,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _registerUser() async {
    registrationInProgress = true ;
    setState(() {

    });
    Map<String, dynamic> requestBody = {

        "email":_emailTEController.text.trim(),
        "firstName":_firstNameTEController.text.trim(),
        "lastName": _lastNameTEController.text.trim(),
        "mobile":_mobileTEController.text.trim(),
        "password":_passwordTEController.text

    };
    NetworkResponse response = await NetworkClient.postRequest(url: Urls.registerUrl, body: requestBody) ;
    registrationInProgress = false ;
    setState(() {

    });
    if(response.isSuccess){
      showScaffoldMessage(context, 'User Registered Successfully') ;
    }
    else{
      showScaffoldMessage(context, response.errorMessage, true) ;
    }
  }


  void _onTapSubmitButton() {

    if (_formKey.currentState!.validate()) {
      _registerUser();
    }


  }

  void _onTapSignInButton() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
