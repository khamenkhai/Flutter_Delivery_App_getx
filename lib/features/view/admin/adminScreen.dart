import 'package:delivery_app/features/controllers/adminControllers/categoryController.dart';
import 'package:delivery_app/features/controllers/adminControllers/deliveryController.dart';
import 'package:delivery_app/features/controllers/adminControllers/driverController.dart';
import 'package:delivery_app/features/controllers/adminControllers/orderController.dart';
import 'package:delivery_app/features/controllers/adminControllers/productController.dart';
import 'package:delivery_app/features/controllers/userControllers/userController.dart';
import 'package:delivery_app/features/repositories/adminRepositories/categoryRepo.dart';
import 'package:delivery_app/features/repositories/adminRepositories/deliveryRepository.dart';
import 'package:delivery_app/features/repositories/adminRepositories/driverRepo.dart';
import 'package:delivery_app/features/repositories/adminRepositories/orderRepository.dart';
import 'package:delivery_app/features/repositories/adminRepositories/productRepositoryes.dart';
import 'package:delivery_app/features/repositories/userRepositories/userRepository.dart';
import 'package:delivery_app/features/view/admin/mainScreens/adminDashboard.dart';
import 'package:delivery_app/features/view/admin/mainScreens/orderHistoryScreen.dart';
import 'package:delivery_app/features/view/admin/mainScreens/ordersScreen.dart';
import 'package:delivery_app/features/view/admin/mainScreens/settingScreen.dart';
import 'package:delivery_app/const/fbConst.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ionicons/ionicons.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int currentIndex = 0;
  CategoryRepository categoryRepository =
      CategoryRepository(firestore: FirebaseConstant.firestore);
  ProductRepository productRepository =
      ProductRepository(firestore: FirebaseConstant.firestore);
  OrderRepository orderRepository =
      OrderRepository(firestore: FirebaseConstant.firestore);
  DeliveryRepository deliveryRepository =
      DeliveryRepository(firestore: FirebaseConstant.firestore);
  DriverReposiotry driverReposiotry =
      DriverReposiotry(firestore: FirebaseConstant.firestore);

  @override
  void initState() {
    Get.put(CategoryController(categoryRepository: categoryRepository));
    Get.put(ProductController(productRepository: productRepository));
    Get.put(OrderController(orderRepository: orderRepository));
    Get.put(DeliveryController(deliveryRepository: deliveryRepository));
    Get.put(DriverController(driverReposiotry: driverReposiotry));
    Get.put(UserController(userRepository: UserRepository()));
    super.initState();
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List _pages = [
    AdminDashboardScreen(),
    OrderScreen(),
    AdminOrderHistoryScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: GNav(
        selectedIndex: currentIndex,
        onTabChange: (value) {
          changePage(value);
        },
        mainAxisAlignment: MainAxisAlignment.center,
        backgroundColor: Colors.white,
        gap: 7,
        tabActiveBorder: Border.all(color: Colors.transparent),
        activeColor: Theme.of(context).primaryColor,
        color: Colors.grey.shade400,
        tabBackgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        tabMargin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        tabs: [
          GButton(icon: Ionicons.home, text: "Home"),
          GButton(icon: Ionicons.bag, text: "Order"),
          GButton(icon: Icons.list_alt_rounded, text: "History"),
          GButton(icon: Icons.settings, text: "Setting"),
        ],
      ),
    );
  }
}
