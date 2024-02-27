import 'package:delivery_app/features/view/user/userSetting/userSettingScreen.dart';
import 'package:flutter/material.dart';

class DriverSettingScreen extends StatefulWidget {
  const DriverSettingScreen({super.key});

  @override
  State<DriverSettingScreen> createState() => _DriverSettingScreenState();
}

class _DriverSettingScreenState extends State<DriverSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return UserSettingScreenScreen();
  }
}