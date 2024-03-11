import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/features/view/common/my_textfield.dart';
import 'package:delivery_app/features/view/user/commonWidgets/primaryButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                      height: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        //name text field
                        MyTextFormField(
                          emailController: nameController,
                          hintText: "Username",
                          icon: Icons.person,
                          iconColor: Theme.of(context).primaryColor,
                        ),
                        //phone number text field
                        SizedBox(height: 15),
                        MyTextFormField(
                          emailController: phoneController,
                          hintText: "Phone No.",
                          icon: Icons.phone,
                          iconColor: Theme.of(context).primaryColor,
                        ),
                        //email text field
                        SizedBox(height: 15),
                        MyTextFormField(
                          emailController: emailController,
                          hintText: "Email",
                          icon: Icons.person,
                          iconColor: Theme.of(context).primaryColor,
                        ),
                        //password text field
                        SizedBox(height: 15),
                        TextFormField(
                          controller: passwordController,
                          obscureText: obscureText,
                          validator: (value) {
                            if (value == null || value == "") {
                              return " Password can't be empty!";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Password",
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            prefixIcon:
                                Icon(Icons.lock, color: Theme.of(context).primaryColor),
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
                              text: "Register",
                              borderRadius: 30,
                              loading: authController.loading.value,
                              textColor: Colors.white,
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  authController.creteNewAccount(
                                      email: emailController.text,
                                      context: context,
                                      password: passwordController.text,
                                      username: nameController.text,
                                      phoneNumber: phoneController.text);

                                  emailController.clear();
                                  passwordController.clear();
                                  nameController.clear();
                                  phoneController.clear();
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
                        MyText(text: "Already have an account?", fontSize: 15),
                        TextButton(
                          onPressed: () {
                            //navigate to login screen
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
