import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/models/orderModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AdminOrderHistoryScreen extends StatefulWidget {
  const AdminOrderHistoryScreen({super.key});

  @override
  State<AdminOrderHistoryScreen> createState() => _AdminOrderHistoryScreenState();
}

class _AdminOrderHistoryScreenState extends State<AdminOrderHistoryScreen> {
  @override
  void initState() {
    orderController.getOrdersByStatus(OrderStatus.history);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0.2,
        title: Text("History"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Obx(
          () {
            return ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10),
              itemCount: orderController.orderHistory.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 12);
              },
              itemBuilder: (context, index) {
                return _deliveryCardWidget(
                  orderController.orderHistory[index],
                  context,
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _deliveryCardWidget(OrderModel order, BuildContext context) {
    return InkWell(
      onTap: () {
       
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
            height: 75,
            width: 75,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade100,
            ),
            child: Image.asset('assets/images/fast-delivery.png',fit: BoxFit.cover,),
          ),
            SizedBox(width: 10),
            Expanded(
              // Use Expanded to allow the text to occupy remaining space
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      MyText(text: "ID : ${order.orderId}"),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: getColorByStatus(order.orderStatus.toString()),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: MyText(
                          text: "${order.orderStatus}",
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 7),
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.lightGreen, size: 20),
                      SizedBox(width: 6),
                      Text(
                        "${order.userName}",
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          color: Colors.lightGreen, size: 20),
                      SizedBox(width: 6),
                      Flexible(
                        // Use Flexible to allow text to wrap if needed
                        child: Text(
                          "${order.address}",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.access_time_outlined,
                          color: Colors.lightGreen, size: 20),
                      SizedBox(width: 6),
                      Text(
                        "${DateFormat('d MMMM ,y  hh:mm a').format(order.time!)}",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
