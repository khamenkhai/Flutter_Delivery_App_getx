import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/features/view/admin/dashboardSubScreen/allDriversScreen.dart';
import 'package:delivery_app/features/view/admin/dashboardSubScreen/allProducts.dart';
import 'package:delivery_app/features/view/admin/dashboardSubScreen/allCategoriesScreen.dart';
import 'package:delivery_app/features/view/admin/dashboardSubScreen/totalSale.dart';
import 'package:delivery_app/features/view/admin/mainScreens/deliveryScreen.dart';
import 'package:delivery_app/features/view/admin/mainScreens/totalOrders.dart';
import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';


///admin dashboard home screen
class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  void initState() {
    orderController.getAllOrders();
    driverController.getDrivers();
    deliveryController.getAllDeliveries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Admin Dashboard"),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15, top: 2),
          child: Obx(
            () {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _gridWidget(
                                  image: "assets/images/sale.png",
                                  title: "Total Sales",
                                  subtitle: "${orderController.getTotalSales()} MMK",
                                  iconColor: Colors.orange,
                                  icon: Ionicons.cart,
                                  onTap: () {
                                    navigatorPush(context, TotalSalesScreen());
                                  }),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: _gridWidget(
                                  image: "assets/images/dairy-products.png",
                                  title: "All Products",
                                  iconColor: Colors.indigo,
                                  icon: Icons.format_align_justify_outlined,
                                  subtitle: "${productController.products.length}",
                                  onTap: () {
                                    navigatorPush(context, AllProductsScreen());
                                  }),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: _gridWidget(
                                  image: "assets/images/app.png",
                                  title: "All Categories",
                                  iconColor: Colors.blue,
                                  icon: Icons.chrome_reader_mode_outlined,
                                  subtitle: "${categoryController.categories.length}",
                                  onTap: () {
                                    navigatorPush(context, CategoriesScreen());
                                  }),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: _gridWidget(
                                  image: "assets/images/delivery-bike.png",
                                  title: "Drivers",
                                  icon: CupertinoIcons.person_2_fill,
                                  iconColor: Colors.green,
                                  subtitle: "${driverController.drivers.length}",
                                  onTap: () {
                                    navigatorPush(context, AllDriversScreen());
                                  }),
                            ),
                          ],
                        ),
                    
                        Row(
                          children: [
                            Expanded(
                              child: _gridWidget(
                                image: "assets/images/delivery-bike.png",
                                title: "Total Orders",
                                icon: Ionicons.list,
                                iconColor: Colors.red,
                                height: 200,
                                subtitle: "${orderController.allOrders.length}",
                                onTap: () {
                                  navigatorPush(context, TotalOrders());
                                },
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: _gridWidget(
                                image: "assets/images/delivery-bike.png",
                                title: "Total Deliveries",
                                icon: Icons.delivery_dining,
                                iconColor: Colors.amber,
                                height: 200,
                                subtitle: "${deliveryController.allDeliveries.length}",
                                onTap: () {
                                  navigatorPush(context, DeliveryScreen());
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 45),
                            
                       //Container(height: 500,width: MediaQuery.of(context).size.height,child: LineChartSample2())
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _gridWidget(
      {required String image,
      required String title,
      required Function() onTap,
      required IconData icon,
      double? height,
      required Color iconColor,
      required String subtitle}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.only(top: 12),
        color: iconColor.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          padding: EdgeInsets.only(top: 35, bottom: 35, left: 13, right: 13),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 17,
                    backgroundColor: iconColor,
                    child: Icon(icon, color: Colors.white, size: 18),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(text: "${title}"),
                        SizedBox(height: 5),
                        MyText(
                          text: "${subtitle}",
                          fontWeight: FontWeight.w500,
                          fontSize: 19,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
          // child: Column(
          //   children: [
          //     Container(
          //         height: 80,
          //         padding: EdgeInsets.symmetric(vertical: 7),
          //         child: Image.asset(image, fit: BoxFit.cover)),
          //     SizedBox(height: 15),
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         MyText(text: title, fontSize: 17),
          //         SizedBox(height: 7),
          //         MyText(text: subtitle, fontSize: 15, color: Colors.grey),
          //       ],
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
