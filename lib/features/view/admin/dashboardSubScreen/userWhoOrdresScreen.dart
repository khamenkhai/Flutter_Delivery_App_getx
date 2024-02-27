import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/features/view/driver/mainScreen/driverDeliveryDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserWhoOrdersScreen extends StatefulWidget {
  const UserWhoOrdersScreen({super.key});

  @override
  State<UserWhoOrdersScreen> createState() => _UserWhoOrdersScreenState();
}

class _UserWhoOrdersScreenState extends State<UserWhoOrdersScreen> {
  bool todayOrdersEmpty() {
    List todayList = driverDeliveryController.deliveryList.where((d) {
      return d.orderTime!.year == DateTime.now().year &&
          d.orderTime!.month == DateTime.now().month &&
          d.orderTime!.day == DateTime.now().day;
    }).toList();
    return todayList.isEmpty ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0.2,
        backgroundColor: Colors.white,
        title: Text("Support"),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Obx(
            () => todayOrdersEmpty()
                ? Container(
                    height: MediaQuery.of(context).size.height - 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(
                          text: "No Orders Today",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15, left: 10),
                        child: MyText(
                          text: "Today",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ...driverDeliveryController.deliveryList
                          // .where((d) {
                          //   return d.orderTime!.year == DateTime.now().year &&
                          //       d.orderTime!.month == DateTime.now().month &&
                          //       d.orderTime!.day == DateTime.now().day;
                          // })
                          .map(
                        (e) => ListTile(
                          onTap: () {
                            navigatorPush(
                                context, DeliveryDetailScreen(delivery: e));
                          },
                          leading: CircleAvatar(
                              backgroundColor: Colors.grey.shade100,
                              child: Icon(
                                Icons.person,
                                color: Colors.lightGreen,
                              )),
                          title: Text("${e.customerName}"),
                          subtitle: Text("${timeago.format(e.orderTime!)}"),
                          trailing: Icon(
                            Icons.circle,
                            color: getColorByStatus(e.status.toString()),
                            size: 15,
                          ),
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
