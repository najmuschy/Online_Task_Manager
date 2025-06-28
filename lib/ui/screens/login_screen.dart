import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:ui_design1/ui/widgets/screen_background.dart';

import '../utils/assets_path.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding:  EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80),
              Text(
                'Get Started With',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(height: 20),
              TextFormField(decoration: InputDecoration(hintText: 'Email')),
              SizedBox(height: 6),
              TextFormField(decoration: InputDecoration(hintText: 'Password')),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {},
                child: Icon(Icons.arrow_forward),
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
                            recognizer: TapGestureRecognizer()..onTap = _onTapSignInButton
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
    );

  }
  void _onTapSignInButton(){

  }
  void _onTapForgotPasswordButton(){

  }
}
