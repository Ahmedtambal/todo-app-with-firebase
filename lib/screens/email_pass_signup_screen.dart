import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app_with_firebase/controllers/email_pass_signup_controller.dart';

import '../config.dart';

class EmailPassSignupScreen extends StatefulWidget {
  @override
  _EmailPassSignupScreenState createState() => _EmailPassSignupScreenState();
}

class _EmailPassSignupScreenState extends State<EmailPassSignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final EmailPassSignupController _emailPassSignupController = Get.put(EmailPassSignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Sign Up"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
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
                      hintText: "Write Email",
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
                      hintText: "Write Password",
                    ),
                    obscureText: true,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(
                    top: 10,
                  ),
                  child: TextFormField(
                    controller: _rePasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Re-Password",
                      hintText: "Re-Write Password",
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (_rePasswordController.text != _passwordController.text) {
                        return "Password doesn't match";
                      }
                      return null;
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (!_key.currentState!.validate()) {
                      return;
                    }
                    _emailPassSignupController.signup(
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
                      "Sign Up Using Email",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
