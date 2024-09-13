import 'package:flutter/material.dart';
import 'package:sgu_uni/form/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: screenHeight,
        width: screenWidth * 1,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.asset(
                  "assets/logo/logo.png",
                  height: 150,
                  width: 150,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: const Loginform(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
