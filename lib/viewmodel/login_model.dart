import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject/screen/forgot_password.dart';

import '../screen/welcome_screen.dart';
import '../widgets/toast_message.dart';

class LoginViewModel with ChangeNotifier {
  final email = TextEditingController();
  final password = TextEditingController();
  bool isPasswordCorrect = false;
  bool isObscure = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void initialize() {}

  updateStates() {
    notifyListeners();
  }

  void registerMethod(BuildContext context) {
    _auth
        .signInWithEmailAndPassword(
            email: email.text.toString(), password: password.text.toString())
        .then((value) {
      isPasswordCorrect = false;
      email.text = "";
      password.text = "";
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
    }).onError((error, stackTrace) {
      isPasswordCorrect = true;

      flutterToastMessage(error.toString());
    });

    notifyListeners();
  }

  forgotPasswordNavigation(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ForgotPassword()));
    notifyListeners();
  }
}
