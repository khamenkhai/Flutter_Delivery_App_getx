import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/features/controllers/adminControllers/productController.dart';
import 'package:delivery_app/features/repositories/adminRepositories/productRepositoryes.dart';
import 'package:delivery_app/features/controllers/driverControllers/driverDeliveryController.dart';
import 'package:delivery_app/features/repositories/driverRepositories/driverDeliveryRepo.dart';
import 'package:delivery_app/features/view/driver/mainScreen/driverDeliveryHistoryScreen.dart';
import 'package:delivery_app/features/view/driver/mainScreen/driverDeliveryScreen.dart';
import 'package:delivery_app/features/view/driver/mainScreen/driverDashboardScreen.dart';
import 'package:delivery_app/features/view/driver/mainScreen/driverSettingScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ionicons/ionicons.dart';

class DriverScreen extends StatefulWidget {
  const DriverScreen({super.key});

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  int currentIndex = 0;
  var firebaseInstance = FirebaseFirestore.instance;
  DriverDeliveryRepository driverDeliveryRepository =
      DriverDeliveryRepository(firestore: FirebaseFirestore.instance);
  ProductRepository productRepository =
      ProductRepository(firestore: FirebaseFirestore.instance);

  @override
  void initState() {
    Get.put(DriverDeliveryController(
        driverDeliveryRepository: driverDeliveryRepository));
    Get.put(ProductController(productRepository: productRepository));
    super.initState();
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List _pages = [
    DriverHomeScreen(),
    DriverDeliveryScreen(),
    DriverHistoryScreen(),
    DriverSettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GNav(
              selectedIndex: currentIndex,
              onTabChange: (value) {
                changePage(value);
              },
              mainAxisAlignment: MainAxisAlignment.center,
              backgroundColor: Colors.transparent,
              gap: 7,
              tabActiveBorder: Border.all(color: Colors.transparent),
              activeColor: Theme.of(context).primaryColor,
              color: Colors.grey.shade400,
              tabBackgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              tabMargin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              tabs: [
                GButton(
                  icon: Ionicons.home,
                  text: "Dashboard",
                ),
                GButton(icon: Icons.delivery_dining_sharp, text: "Delivery"),
                GButton(icon: Icons.access_time, text: "History"),
                GButton(icon: Icons.settings, text: "Setting"),
              ]),
        ],
      ),
      // bottomNavigationBar: GNav(
      //     selectedIndex: currentIndex,
      //     onTabChange: (value) {
      //       changePage(value);
      //     },
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     backgroundColor: Colors.white,
      //     gap: 7,
      //     activeColor: Colors.white,
      //     color: Theme.of(context).primaryColor,
      //     tabBackgroundColor: Theme.of(context).primaryColor,
      //     padding: EdgeInsets.all(10),
      //     tabMargin: EdgeInsets.symmetric(horizontal: 5, vertical: 12),
      //     tabs: [
      //       GButton(
      //         icon: Ionicons.home,
      //         text: "Dashboard",
      //       ),
      //       GButton(icon: Ionicons.bag, text: "Order"),
      //       GButton(icon: Icons.delivery_dining, text: "Delivery"),
      //       GButton(icon: Icons.settings, text: "Setting"),
      //     ]),
    );
  }
}
