import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/features/view/admin/subScreens/adminSideDeliveryDetail.dart';
import 'package:delivery_app/models/deliveryModel.dart';
import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  @override
  void initState() {
    deliveryController.getDeliveriesByStatus(DeliveryStatus.pending);
    super.initState();
  }

  List status = [
    DeliveryStatus.pending,
    DeliveryStatus.active,
    DeliveryStatus.complete,
    "Cancel"
  ];

  String currrentStatus = OrderStatus.pending;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(title: Text("Deliveries"), backgroundColor: Colors.white),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(bottom: 15, right: 0),
            decoration: BoxDecoration(color: Colors.white),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...status.map(
                    (e) => Container(
                      margin: status.indexOf(e) == 0
                          ? EdgeInsets.only(left: 20)
                          : status.length == status.indexOf(e)
                              ? EdgeInsets.only(right: 100)
                              : EdgeInsets.only(),
                      child: _deliveryStatusButton(
                        isCurrent: e == currrentStatus,
                        status: e,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => deliveryController.loading.value
                  ? loadingWidget()
                  : Column(
                      children: [
                        Expanded(
                          child: currrentStatus == DeliveryStatus.pending
                              ? ListView.separated(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
                                  itemCount: deliveryController
                                      .pendingDeliveries.length,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: 10);
                                  },
                                  itemBuilder: (context, index) {
                                    return _deliveryCardWidget(
                                        deliveryController
                                            .pendingDeliveries[index],
                                        context);
                                  },
                                )
                              : currrentStatus == DeliveryStatus.active
                                  ?

                                  /// active**********

                                  ListView.separated(
                                      padding: EdgeInsets.only(
                                          top: 10, left: 10, right: 10),
                                      itemCount: deliveryController
                                          .onWayDeliveries.length,
                                      separatorBuilder: (context, index) {
                                        return SizedBox(height: 10);
                                      },
                                      itemBuilder: (context, index) {
                                        return _deliveryCardWidget(
                                            deliveryController
                                                .onWayDeliveries[index],
                                            context);
                                      },
                                    )
                                  : currrentStatus == DeliveryStatus.complete
                                      ?

                                      ///completed orders orders **********
                                      ListView.separated(
                                          padding: EdgeInsets.only(
                                              top: 10, left: 10, right: 10),
                                          itemCount: deliveryController
                                              .completedDeliveries.length,
                                          separatorBuilder: (context, index) {
                                            return SizedBox(height: 10);
                                          },
                                          itemBuilder: (context, index) {
                                            return _deliveryCardWidget(
                                                deliveryController
                                                    .completedDeliveries[index],
                                                context);
                                          },
                                        )
                                      : Container(),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _deliveryStatusButton(
      {required bool isCurrent, required String status}) {
    return InkWell(
      borderRadius: BorderRadius.circular(7),
      onTap: () {
        currrentStatus = status;
        setState(() {
          deliveryController.getDeliveriesByStatus(status);
        });
        // setState(() {
        //   driverDeliveryController.getDeliveriesByStatus(status);
        // });
      },
      child: Container(
        margin: EdgeInsets.only(right: 12),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: isCurrent
                ? Border.all(width: 0, color: Colors.transparent)
                : Border.all(width: 0.5, color: Colors.grey),
            color: isCurrent ? Colors.lightGreen : Colors.transparent),
        child: MyText(
            text: status,
            color: isCurrent ? Colors.white : Colors.black,
            fontSize: 14,
            fontWeight: isCurrent ? FontWeight.bold : null),
      ),
    );
  }
}

Widget _deliveryCardWidget(DeliveryModel delivery, BuildContext context) {
  return GestureDetector(
    onTap: (){
      navigatorPush(context, DeliveryDetail(delivery: delivery));
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
            child: Image.asset(
              'assets/images/fast-delivery.png',
              fit: BoxFit.cover,
            ),
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
                          color: getColorByStatus(delivery.status.toString()),
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
                    SizedBox(width: 15),
                    Icon(
                      Icons.delivery_dining,
                      size: 20,
                      color: Colors.lightGreen,
                    ),
                    Text(
                      "${delivery.deliveryManName}",
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
