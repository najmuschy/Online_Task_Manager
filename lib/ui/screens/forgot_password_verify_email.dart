import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ui_design1/ui/screens/forgot_password_verify_pin.dart';

import 'package:ui_design1/ui/widgets/screen_background.dart';

import '../utils/assets_path.dart';

class ForgotPasswordVerifyEmail extends StatefulWidget {
  const ForgotPasswordVerifyEmail({super.key});

  @override
  State<ForgotPasswordVerifyEmail> createState() => _ForgotPasswordVerifyEmailState();
}

class _ForgotPasswordVerifyEmailState extends State<ForgotPasswordVerifyEmail> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

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
                  'Your Email Address',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(height: 8,),
                Text(
                  'A 6 digit verification code will be sent to your \n e-mail address',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: 20),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTEController,
                  decoration: InputDecoration(hintText: 'Email'),
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

  void _onTapSubmitButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordVerifyPin())) ;
  }
  void _onTapSignInButton() {
   Navigator.pop(context) ;
  }
 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEController.dispose();
  }
  void _onTapForgotPasswordButton() {}
}
