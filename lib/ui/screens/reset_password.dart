import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../data/service/network_client.dart';
import '../../data/utils/urls.dart';
import '../utils/assets_path.dart';
import '../widgets/scaffold_message.dart';
import '../widgets/screen_background.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email ;
  final String otp ;
  const ResetPasswordScreen({super.key, required this.email, required this.otp});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordTEController =
      TextEditingController();
  final TextEditingController _confirmNewPasswordTEController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                const SizedBox(height: 80),
                Text(
                  'Set Password',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Password must be a minimum of 8 characters with letter and number combination.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: _newPasswordTEController,
                  decoration: const InputDecoration(hintText: 'Set Password'),
                  validator:  (String? value){
                    if((value?.isEmpty ?? true) || (value!.length<6)){
                      return 'YOUR FINGERS GET CUT OFF? 6 CHARACTERS IS NOT ROCKET SCIENCE!' ;
                    }

                    else{
                      return null ;
                    }
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _confirmNewPasswordTEController,
                  decoration: InputDecoration(hintText: 'Confirm Password'),
                  validator: (String? value){
                    if((value?.isEmpty ?? true) || (value!.length<6)){
                      return 'YOUR FINGERS GET CUT OFF?? 6 CHARACTERS IS NOT ROCKET SCIENCE!' ;
                    }
                    else if(value!=_newPasswordTEController.text){
                      return 'Make sure your passwords match doofus!' ;
                    }
                    else{
                      return null ;
                    }

                  },
                ),

                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _onTapSubmitButton,
                  child: Icon(Icons.arrow_forward),
                ),
                const SizedBox(height: 32),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(text: "Have an account?"),
                        TextSpan(
                          text: "Sign In",
                          style: const TextStyle(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> onResetPassword() async{
    String email = widget.email;
    String otp = widget.otp;
    Map<String, dynamic> requestBody = {
      "email":email,
      "OTP": otp,
      "password":_newPasswordTEController.text
    };
    NetworkResponse response = await NetworkClient.postRequest(url: Urls.resetPassword, body: requestBody) ;
    if(response.isSuccess){
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (predicate) => false,
      );
      showScaffoldMessage(context, response.data!['data']);
    }
    else{
      showScaffoldMessage(context, 'Something went wrong, please try again from the start') ;
    }
  }
  void _onTapSubmitButton() {

    if(_formKey.currentState!.validate()){
      onResetPassword();
    }

  }
  void _onTapSignInButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (predicate) => false,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _newPasswordTEController.dispose();
    _confirmNewPasswordTEController.dispose();
  }

  void _onTapForgotPasswordButton() {}
}
