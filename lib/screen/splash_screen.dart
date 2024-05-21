import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myproject/screen/home_screen.dart';
import 'package:myproject/screen/signup_screen.dart';
import 'package:myproject/screen/welcome_screen.dart';

import '../authservices/authservices.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
   _loadScreen();
  }
  Future<void> _loadScreen() async {
    final isLoggedIn = await AuthService().isLoggedIn();
    Timer(
      const Duration(seconds: 3),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => isLoggedIn ? WelcomeScreen() : SignUpScreen(),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/splash_screen.jpeg"),
      ),
    );
  }
}
