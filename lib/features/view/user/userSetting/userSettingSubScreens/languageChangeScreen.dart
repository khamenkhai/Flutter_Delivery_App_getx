import 'package:flutter/material.dart';

class UserLanguageScreen extends StatefulWidget {
  const UserLanguageScreen({super.key});

  @override
  State<UserLanguageScreen> createState() => _UserLanguageScreenState();
}

class _UserLanguageScreenState extends State<UserLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Language")),
    );
  }
}

