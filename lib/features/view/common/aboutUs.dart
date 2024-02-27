import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15,right: 15,top: 15),
            child: MyText(
              text:
                  "At [Your App Name], we're passionate about connecting people with delicious food from their favorite local restaurants, all with the convenience of a few taps on their smartphone. Founded with the mission to revolutionize the way people experience food delivery, we strive to provide an exceptional dining experience for our customers. Whether you're craving a classic comfort meal or eager to explore new culinary delights, our platform offers a diverse range of options to satisfy every palate. With a commitment to quality, convenience, and customer satisfaction, we work closely with our restaurant partners to ensure that each order is delivered promptly and with care. From busy weeknights to leisurely weekends, [Your App Name] is here to make every mealtime a delightful experience",
            fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
