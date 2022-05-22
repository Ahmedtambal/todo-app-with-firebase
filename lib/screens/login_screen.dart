import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app_with_firebase/controllers/login_controller.dart';
import 'package:to_do_app_with_firebase/screens/email_pass_signup_screen.dart';

import '../config.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(
            bottom: 80,
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: 80,
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x4400F58D),
                        blurRadius: 30,
                        offset: Offset(10, 10),
                        spreadRadius: 0),
                  ],
                ),
                child: Image(
                  image: AssetImage("assets/logo_round.png"),
                  width: 150,
                  height: 150,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(
                  top: 40,
                ),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    hintText: "Write Email Here",
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(
                  top: 10,
                ),
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    hintText: "Write Password Here",
                  ),
                  obscureText: true,
                ),
              ),
              InkWell(
                onTap: () {
                  _loginController.signIn(
                    context: context,
                    emailController: _emailController,
                    passwordController: _passwordController,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [k_primaryColor, k_secondaryColor],
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                  child: Center(
                      child: Text(
                    "Login With Email",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => EmailPassSignupScreen());
                },
                child: Text("Signup using Email"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
