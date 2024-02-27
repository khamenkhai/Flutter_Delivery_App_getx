import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/features/view/auth/signUpScreen.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/features/view/common/my_textfield.dart';
import 'package:delivery_app/features/view/user/commonWidgets/primaryButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 35),
              Text(
                "Deliverrio".toUpperCase(),
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                  fontFamily: "nunito",
                  letterSpacing: 8,
                ),
              ),
              SizedBox(height: 40),
              Container(
                child: Lottie.asset(
                  "assets/animations/delivery.json",
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 40),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    //email text field
                    MyTextFormField(
                      emailController: emailController,
                      hintText: "Email",
                      icon: Icons.person,
                      iconColor: Colors.lightGreen,
                    ),
                    //password text field
                    SizedBox(height: 15),
                    TextFormField(
                      controller: passwordController,
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        hintText: "Password",
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        prefixIcon: Icon(Icons.lock, color: Colors.lightGreen),
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            icon: Icon(obscureText
                                ? Icons.visibility
                                : Icons.visibility_off)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),

                    SizedBox(height: 25),
                    Obx(() => PrimaryButton(
                          text: "Login",
                          borderRadius: 30,
                          loading: authController.loading.value,
                          textColor: Colors.white,
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              authController.loginAccount(
                                email: emailController.text,
                                context: context,
                                password: passwordController.text,
                              );

                              emailController.clear();
                              passwordController.clear();
                            }
                          },
                          height: 50,
                          ml: 0,
                          mr: 0,
                          mb: 15,
                        ))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(text: "Don't have an account?", fontSize: 15),
                    TextButton(
                      onPressed: () {
                        //navigate to signup screen
                        navigatorPush(context, RegisterScreen());
                      },
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                          color: Colors.lightGreen,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    
    
    );
  }
}

