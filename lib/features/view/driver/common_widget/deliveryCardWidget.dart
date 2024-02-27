import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/features/view/driver/mainScreen/driverDeliveryDetailScreen.dart';
import 'package:delivery_app/models/deliveryModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget deliveryCardWidget(DeliveryModel delivery, BuildContext context) {
  return InkWell(
    onTap: () {
      navigatorPush(context, DeliveryDetailScreen(delivery: delivery));
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
                    MyText(text: "ID : ${delivery.deliveryId}"),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                      decoration: BoxDecoration(
                          color: getColorByStatus(delivery.status!),
                          borderRadius: BorderRadius.circular(4)),
                      child: MyText(
                        text: "${delivery.status}",
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
                      "${delivery.customerName}",
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
                        "${delivery.address}",
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
                      "${DateFormat('d MMMM ,y  hh:mm a').format(delivery.orderTime!)}",
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
