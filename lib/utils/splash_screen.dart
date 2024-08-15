import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_wave/presentation/AuthManagement/sign_in.dart';
import 'package:golden_wave/presentation/widgets/nav_bar.dart';
import 'package:golden_wave/utils/explain_screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Widget _nextScreen = const Scaffold(
    body: Center(
      child: CircularProgressIndicator(),
    ),
  ); // Placeholder screen

  @override
  void initState() {
    super.initState();
    _determineNextScreen();
  }

  Future<void> _determineNextScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime) {
      setState(() {
        _nextScreen = const ExplainScreens();
      });
      prefs.setBool('isFirstTime', false);
    } else {
      User? currentUser = FirebaseAuth.instance.currentUser;
      setState(() {
        if (currentUser != null) {
          _nextScreen = const NavBar(); 
        } else {
          _nextScreen = const SignIn(); 
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 2000,
      splashIconSize: 180.r,
      backgroundColor: const Color(0xff222222),
      splash: Container(
        width: 130.w,
        height: 130.h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/logo.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      nextScreen: _nextScreen,
    );
  }
}
