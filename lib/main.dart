import 'package:delivery_app/features/controllers/auth/auth_controller/auth_controller.dart';
import 'package:delivery_app/features/repositories/auth_repo/auth_repo.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/features/repositories/userRepositories/userRepository.dart';
import 'package:delivery_app/features/view/admin/adminScreen.dart';
import 'package:delivery_app/features/view/auth/loginScreen.dart';
import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/firebase_options.dart';
import 'package:delivery_app/features/view/driver/driverScreen.dart';
import 'package:delivery_app/features/view/user/userScreen.dart';
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

  final data =  Get.put(AuthController(
            authRepository: AuthRepository(),
            userRepository: UserRepository()));
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      // initialBinding: BindingsBuilder(() {
      //   Get.put(AuthController(
      //       authRepository: AuthRepository(),
      //       userRepository: UserRepository()));
      // }),
      theme: ThemeData(
        useMaterial3: false,
        primaryColor: ThemeConstant.primaryColor,
        primarySwatch: Colors.lightGreen,
        scaffoldBackgroundColor: Colors.grey.shade50,
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0.1,
            foregroundColor: Colors.black),
        buttonTheme: ButtonThemeData(buttonColor: ThemeConstant.primaryColor),
        fontFamily: "inter",
      ),
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

// MaterialColor generateMaterialColor(Color color) {
//   // Create a custom MaterialColor from a single color
//   List<int> strengths = <int>[50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
//   Map<int, Color> swatch = <int, Color>{};

//   for (int i = 0; i < 10; i++) {
//     final int strength = strengths[i];
//     final double weight = 0.5 - (i / 20);
//     final Color blend = Color.lerp(Colors.white, color, weight)!;
//     swatch[strength] = blend;
//   }

//   return MaterialColor(color.value, swatch);
// }
