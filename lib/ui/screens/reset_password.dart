import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ui_design1/ui/screens/forgot_password_verify_pin.dart';
import 'package:ui_design1/ui/screens/login_screen.dart';

import 'package:ui_design1/ui/widgets/screen_background.dart';

import '../utils/assets_path.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

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
                SizedBox(height: 80),
                Text(
                  'Set Password',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(height: 8),
                Text(
                  'Password must be a minimum of 8 characters with letter and number combination.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: 20),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: _newPasswordTEController,
                  decoration: InputDecoration(hintText: 'Set Password'),
                ),
                SizedBox(height: 8),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _confirmNewPasswordTEController,
                  decoration: InputDecoration(hintText: 'Confirm Password'),
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

  void _onTapSubmitButton() {}
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
