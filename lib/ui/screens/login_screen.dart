import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ui_design1/data/service/network_client.dart';
import 'package:ui_design1/data/utils/urls.dart';
import 'package:ui_design1/data/models/login_model.dart';
import 'package:ui_design1/ui/controller/auth_controller.dart';
import 'package:ui_design1/ui/screens/main_bottom_nav_screen.dart';
import 'package:ui_design1/ui/screens/register_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:ui_design1/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:ui_design1/ui/widgets/scaffold_message.dart';
import 'package:ui_design1/ui/widgets/screen_background.dart';


import '../utils/assets_path.dart';
import 'forgot_password_verify_email.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loginUserProgress = false ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80),
                Text(
                  'Get Started With',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(height: 20),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTEController,
                  decoration: InputDecoration(hintText: 'Email'),
                  validator: (String? value){
                    String email = value?.trim() ?? "" ;
                    if(EmailValidator.validate(email)==false){
                      return 'Enter a valid email bozo' ;
                    }
                    return null ;
                  },
                ),
                SizedBox(height: 6),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordTEController,
                  decoration: InputDecoration(hintText: 'Password'),
                  validator: (String? value){
                    if((value?.isEmpty ?? true) || (value!.length<6)){
                      return 'YOUR FINGERS GET CUT OFF?' ;
                    }
                    else{
                      return null ;
                    }
                  },
                ),
                SizedBox(height: 12),
                Visibility(
                  visible: loginUserProgress == false,
                  replacement: CenteredCircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: _onTapSubmitButton,
                    child: Icon(Icons.arrow_forward),
                  ),
                ),
                SizedBox(height: 32),
                Center(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: _onTapForgotPasswordButton,
                        child: Text('Forgot Password?'),
                      ),
                      SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(text: "Don't have an account?"),
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = _onTapSignUpButton,
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
    );
  }

  Future<void> loginUser() async {
    loginUserProgress =  true ;
    setState(() {});

    Map<String, dynamic> body = {
      "email" : _emailTEController.text ,
      "password" : _passwordTEController.text ,
    };
    NetworkResponse response = await NetworkClient.postRequest(url : Urls.loginUrl, body: body);

    if(response.isSuccess){
      LoginModel loginModel = LoginModel.fromJson(response.data!);
      //Save token to local disk
      AuthController.saveUserInfo(loginModel.token, loginModel.userModel) ;
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MainBottomNavScreen()), (predicate)=>false);
    }
    else{
      showScaffoldMessage(context, response.errorMessage, true) ;
    }
    loginUserProgress =  false ;
    setState(() {});
}

  void _onTapSubmitButton(){
    if(_formKey.currentState!.validate()){
      loginUser();
    }

  }
  void _onTapSignUpButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }

  void _onTapForgotPasswordButton() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgotPasswordVerifyEmail()));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
