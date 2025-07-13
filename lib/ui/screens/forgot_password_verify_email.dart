import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';


import '../../data/service/network_client.dart';
import '../../data/utils/urls.dart';
import '../utils/assets_path.dart';
import '../widgets/scaffold_message.dart';
import '../widgets/screen_background.dart';
import 'forgot_password_verify_pin.dart';

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
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text(
                  'Your Email Address',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 8,),
                Text(
                  'A 6 digit verification code will be sent to your \n e-mail address',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTEController,
                  decoration: const InputDecoration(hintText: 'Email'),
                  validator: (String? value){
                    String email = value?.trim() ?? '' ;
                    if(EmailValidator.validate(email)=='false'){
                      return 'WAKE UP DELULU' ;
                    }
                    return null ;
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
                        const TextSpan(text: "Have an account?"),
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

  Future<void> onVerifyEmail() async{
    NetworkResponse response = await NetworkClient.getRequest(url: Urls.forgotPasswordEmailVerifyUrl(_emailTEController.text)) ;
    print(response.data) ;

    if(response.isSuccess){
      showScaffoldMessage(context, response.data!["data"]) ;
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordVerifyPin(email : _emailTEController.text))) ;
    }
    else{
      showScaffoldMessage(context, response.data!["data"], true);
    }
  }

  void _onTapSubmitButton() async{

    if(_formKey.currentState!.validate()){
      onVerifyEmail();
    }

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
