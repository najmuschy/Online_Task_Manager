import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart'
    show AnimationType, PinCodeFieldShape, PinCodeTextField, PinTheme;
import 'package:ui_design1/data/service/network_client.dart';
import 'package:ui_design1/data/utils/urls.dart';
import 'package:ui_design1/ui/screens/reset_password.dart';
import 'package:ui_design1/ui/widgets/scaffold_message.dart';

import 'package:ui_design1/ui/widgets/screen_background.dart';

import '../utils/assets_path.dart';
import 'login_screen.dart';

class ForgotPasswordVerifyPin extends StatefulWidget {
  final String email ;
  const ForgotPasswordVerifyPin({super.key, required this.email} );

  @override
  State<ForgotPasswordVerifyPin> createState() =>
      _ForgotPasswordVerifyPinState();
}

class _ForgotPasswordVerifyPinState extends State<ForgotPasswordVerifyPin> {
  final TextEditingController _pinCodeTEController = TextEditingController();

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
                SizedBox(height: 80),
                Text(
                  'PIN Verification',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(height: 8),
                Text(
                  'A 6 digit verification code will be sent to your \n e-mail address',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: 20),
                PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    selectedColor: Colors.green,
                    inactiveColor: Colors.green,
                    selectedBorderWidth: 1,
                    inactiveBorderWidth: 1,
                    activeBorderWidth: 3,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,

                  controller: _pinCodeTEController,

                  appContext: context,
                ),

                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _onTapSubmitButton,
                  child: Icon(Icons.arrow_forward),
                ),
                SizedBox(height: 32),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(text: "Have an account?"),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() async{
    String email = widget.email ;

    NetworkResponse response = await NetworkClient.getRequest(url: Urls.forgotPasswordEmailVerifyPin (email, _pinCodeTEController.text)) ;
    if(response.isSuccess){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResetPasswordScreen(email: email, otp : _pinCodeTEController.text )),
      );
      showScaffoldMessage(context, '${response.data!['data']} Enter a 6 digit password') ;
    }
    else{
      showScaffoldMessage(context, response.data!['data']);
    }

  }

  void _onTapSignInButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (pre) => false,
    );
  }

  void _onTapForgotPasswordButton() {}
  @override
  void dispose() {
    // TODO: implement dispose
    _pinCodeTEController.dispose();
    super.dispose();
  }
}
