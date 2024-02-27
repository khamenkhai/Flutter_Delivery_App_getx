import 'package:delivery_app/features/controllers/adminControllers/categoryController.dart';
import 'package:delivery_app/features/controllers/adminControllers/productController.dart';
import 'package:delivery_app/features/controllers/userControllers/userController.dart';
import 'package:delivery_app/features/repositories/adminRepositories/categoryRepo.dart';
import 'package:delivery_app/features/repositories/adminRepositories/productRepositoryes.dart';
import 'package:delivery_app/const/fbConst.dart';
import 'package:delivery_app/features/controllers/userControllers/cartController.dart';
import 'package:delivery_app/features/controllers/userControllers/userOrderController.dart';
import 'package:delivery_app/features/controllers/userControllers/userProductController.dart';
import 'package:delivery_app/features/repositories/userRepositories/userOrderRepository.dart';
import 'package:delivery_app/features/repositories/userRepositories/userProductRepo.dart';
import 'package:delivery_app/features/repositories/userRepositories/userRepository.dart';
import 'package:delivery_app/features/view/user/userFav/userFavScreen.dart';
import 'package:delivery_app/features/view/user/home/userHomeScreen.dart';
import 'package:delivery_app/features/view/user/userOrder/userOrderScreen.dart';
import 'package:delivery_app/features/view/user/userSetting/userSettingScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ionicons/ionicons.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  int currentIndex = 0;
  CategoryRepository categoryRepository = CategoryRepository(firestore: FirebaseConstant.firestore);
  ProductRepository productRepository = ProductRepository(firestore: FirebaseConstant.firestore);
  UserProductRepository userProductRepository= UserProductRepository(firestore: FirebaseConstant.firestore);
  UserOrderRepository userOrderRepository = UserOrderRepository(firestore: FirebaseConstant.firestore);

  @override
  void initState() {
    Get.put(CategoryController(categoryRepository: categoryRepository));
    Get.put(ProductController(productRepository: productRepository));
    Get.put(UserProductController(userProductRepository: userProductRepository));
    Get.put(UserCartController());
    Get.put(UserOrderController(userOrderRepository: userOrderRepository));
    Get.put(UserController(userRepository: UserRepository()));
    super.initState();
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List _pages = [
    UserHomeScreen(),
    UserOrderScreen(),
    UserFavScreen(),
    UserSettingScreenScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[currentIndex],
      bottomNavigationBar: GNav(
          selectedIndex: currentIndex,
          onTabChange: (value) {
            changePage(value);
          },
          mainAxisAlignment: MainAxisAlignment.center,
          backgroundColor: Colors.white,
          
          gap: 7,
          activeColor:Colors.lightGreen.shade700,
          color: Colors.grey.shade400,
          tabBackgroundColor: Colors.lightGreen.shade50,
          padding: EdgeInsets.symmetric(horizontal: 22,vertical: 15),
          tabMargin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          tabs: [
            GButton(
              icon: Ionicons.home,
              text: "Home",
            ),
            GButton(icon: Ionicons.bag, text: "Order"),
            GButton(icon: Icons.favorite, text: "Favourites"),
            GButton(icon: Icons.settings, text: "Setting"),
          ]),
    );
  }
}
