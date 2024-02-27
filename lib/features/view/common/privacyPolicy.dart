import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
                text: "Our Mission:",
                fontWeight: FontWeight.bold,
                fontSize: 17),
            SizedBox(height: 10),
            Text(
              "At [Your App Name], our mission is simple: to bring delicious food from local restaurants straight to your doorstep. We believe that great food should be easily accessible to everyone, no matter where they are. With our user-friendly platform and extensive network of restaurant partners, we're here to make ordering your favorite meals a breeze.",
              style: TextStyle(fontSize: 15),
            ),

            ///divider
            SizedBox(height: 25),
            MyText(
                text: "Commitment to Quality:",
                fontWeight: FontWeight.bold,
                fontSize: 17),
            SizedBox(height: 10),
            Text(
              "We're committed to providing our customers with the highest quality dining experience. From carefully selecting our restaurant partners to ensuring that each order is prepared with fresh ingredients and delivered promptly, we prioritize excellence in every aspect of our service. Your satisfaction is our top priority, and we're constantly striving to exceed your expectations.",
              style: TextStyle(fontSize: 15),
            ),

            ///divider
            SizedBox(height: 25),
            MyText(
                text: "Privacy and Security:",
                fontWeight: FontWeight.bold,
                fontSize: 17),
            SizedBox(height: 10),
            Text(
              "At [Your App Name], we understand the importance of privacy and security when it comes to your personal information. That's why we've implemented robust measures to protect your data and ensure your peace of mind. We adhere to strict privacy standards and never share your information with third parties without your consent. With [Your App Name], you can trust that your privacy is always our priority.",
              style: TextStyle(fontSize: 15),
            ),

            ///divider
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
