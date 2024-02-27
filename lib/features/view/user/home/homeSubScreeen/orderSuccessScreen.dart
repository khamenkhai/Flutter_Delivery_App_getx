import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/features/view/user/commonWidgets/primaryButton.dart';
import 'package:delivery_app/features/view/user/userScreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset(
                "assets/animations/delivery.json",
                height: 400,
              ),
            ),
            SizedBox(height: 25),
            MyText(
              text: "Order Placed!!",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 25),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 35),
              child: MyText(
                  text: "Thanks for choosing us for delivering your needs!",
                  textAlign: TextAlign.center),
            ),
            SizedBox(height: 150),
            PrimaryButton(
              text: "Go Back To Home",
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => UserScreen()),
                  (route) => true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
