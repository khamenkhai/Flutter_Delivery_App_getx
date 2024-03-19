import 'package:delivery_app/features/controllers/auth_controller/auth_controller.dart';
import 'package:delivery_app/features/repositories/authReposioory/authRepository.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/features/repositories/userRepositories/userRepository.dart';
import 'package:delivery_app/features/view/admin/adminScreen.dart';
import 'package:delivery_app/features/view/auth/loginScreen.dart';
import 'package:delivery_app/firebase_options.dart';
import 'package:delivery_app/features/view/driver/driverScreen.dart';
import 'package:delivery_app/features/view/user/userMainScreen.dart';
import 'package:delivery_app/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  bool admin = false;

  final data = Get.put(
    AuthController(
      authRepository: AuthRepository(),
      userRepository: UserRepository(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightGreenTheme,
      home: Obx(
        () {
          if (authController.user != null) {
            if (authController.user!.role == "admin") {
              return AdminScreen();
            } else if (authController.user!.role == "driver") {
              return DriverScreen();
            } else {
              return UserScreen();
            }
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}

