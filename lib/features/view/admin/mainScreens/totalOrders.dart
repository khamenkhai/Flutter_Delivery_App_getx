import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/models/orderModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TotalOrders extends StatefulWidget {
  const TotalOrders({super.key});

  @override
  State<TotalOrders> createState() => _TotalOrdersState();
}

class _TotalOrdersState extends State<TotalOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Total Orders"),
      ),
      body: Obx(() => orderController.allOrders.length == 0 ? Center(child: MyText(text: "No Orders",),) : 
      ListView.separated(
        padding: EdgeInsets.only(top: 15,left: 10,right: 10),
        itemCount: orderController.allOrders.length,
        separatorBuilder: (context,index){
          return SizedBox(height: 8);
        },
        itemBuilder: (context,index){
          return _orderCardWidget(orderController.allOrders[index]);
        },
      )
      ),
    );
  }


  Widget _orderCardWidget(OrderModel order){
    return InkWell(
    onTap: () {
     
    },
    child: Container(
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
            child: Image.asset('assets/images/delivery-man.png',fit: BoxFit.cover,),
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
                      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                      decoration: BoxDecoration(
                          color: getColorByStatus(order.orderStatus!),
                          borderRadius: BorderRadius.circular(4)),
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
                    Icon(Icons.person, color: Theme.of(context).primaryColor, size: 20),
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
                        color: Theme.of(context).primaryColor, size: 20),
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
                        color: Theme.of(context).primaryColor, size: 20),
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