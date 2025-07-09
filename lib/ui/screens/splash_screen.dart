import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_design1/ui/controller/auth_controller.dart';
import 'package:ui_design1/ui/screens/login_screen.dart';
import 'package:ui_design1/ui/screens/main_bottom_nav_screen.dart';
import 'package:ui_design1/ui/utils/assets_path.dart';
import 'package:ui_design1/ui/widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _moveToNextScreen();
  }

  @override
  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    final bool isLoggedIn = await AuthController.confirmUserLoggedIn();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>isLoggedIn ? const MainBottomNavScreen() : const LoginScreen()),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(child: SvgPicture.asset(AssetsPath.logoSvg)),
      ),
    );
  }
}
