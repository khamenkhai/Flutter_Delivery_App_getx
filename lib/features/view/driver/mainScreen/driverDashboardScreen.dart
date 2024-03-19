import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/features/view/admin/dashboardSubScreen/userWhoOrdresScreen.dart';
import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/features/view/driver/common_widget/deliveryCardWidget.dart';
import 'package:delivery_app/features/view/driver/mainScreen/deliveryListScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ionicons/ionicons.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {

  @override
  void initState() {
    driverDeliveryController.getDeliveryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      drawer: Drawer(),
      appBar: AppBar(
        elevation: 0,
        title: Text("Dashboard"),
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: (){
            navigatorPush(context, UserWhoOrdersScreen());
          }, icon: Icon(Ionicons.notifications_outline)),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 25),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // MyText(text: "Orders", fontSize: 20),
                    // SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              navigatorPush(
                                  context,
                                  DeliveryListScreen(
                                      deliveryStatus: DeliveryStatus.complete));
                            },
                            child: Container(
                              height: 165,
                              decoration: BoxDecoration(
                                  color: Colors.lightGreen.shade100,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.card_giftcard_rounded,
                                      size: 50, color: Colors.lightGreen),
                                  SizedBox(height: 10),
                                  MyText(
                                    text: "Complete Delivery",
                                    fontSize: 15,
                                  ),
                                  SizedBox(height: 10),
                                  MyText(
                                    text: "11",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              navigatorPush(
                                  context,
                                  DeliveryListScreen(
                                      deliveryStatus: DeliveryStatus.pending));
                            },
                            child: Container(
                              height: 165,
                              decoration: BoxDecoration(
                                  color: Colors.yellow.shade100,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.delivery_dining,
                                      size: 50, color: Colors.amber),
                                  SizedBox(height: 10),
                                  MyText(
                                    text: "Pending Delivery",
                                    fontSize: 15,
                                  ),
                                  SizedBox(height: 10),
                                  MyText(
                                    text: "11",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
              
                    SizedBox(height: 15),
              
                    ///delivery status box
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              navigatorPush(
                                  context,
                                  DeliveryListScreen(
                                      deliveryStatus: DeliveryStatus.active));
                            },
                            child: Container(
                              height: 165,
                              decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.card_giftcard_rounded,
                                      size: 50, color: Colors.blue),
                                  SizedBox(height: 10),
                                  MyText(
                                    text: "Active Delivery",
                                    fontSize: 15,
                                  ),
                                  SizedBox(height: 10),
                                  MyText(
                                    text: "11",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: InkWell(
                            onTap: (){

                              navigatorPush(
                                  context,
                                  DeliveryListScreen(
                                      deliveryStatus: "Cancel"));
                            },
                            child: Container(
                              height: 165,
                              decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(CupertinoIcons.cube_box,
                                      size: 50, color: Colors.red),
                                  SizedBox(height: 10),
                                  MyText(
                                    text: "Cancel Delivery",
                                    fontSize: 15,
                                  ),
                                  SizedBox(height: 10),
                                  MyText(
                                    text: "11",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              MyText(text: "New Orders", fontSize: 18,fontWeight: FontWeight.bold,),
              SizedBox(height: 20),
              Obx(() {
                return Column(
                  children: [
                    ...driverDeliveryController.deliveryList.where((d) {
                      return d.orderTime?.year == DateTime.now().year &&
                          d.orderTime?.month == DateTime.now().month &&
                          d.orderTime?.day == DateTime.now().day;
                    }).map((e) => deliveryCardWidget(e, context))
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
