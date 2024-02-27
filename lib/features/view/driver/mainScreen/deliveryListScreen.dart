import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/features/view/driver/common_widget/deliveryCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryListScreen extends StatefulWidget {
  const DeliveryListScreen({super.key, required this.deliveryStatus});
  final String deliveryStatus;

  @override
  State<DeliveryListScreen> createState() => _DeliveryListScreenState();
}

class _DeliveryListScreenState extends State<DeliveryListScreen> {
  @override
  void initState() {
    driverDeliveryController.getDeliveriesByStatus(widget.deliveryStatus);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0.2,
        title: Text(
            "${widget.deliveryStatus} delivery list".capitalize.toString()),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Obx(
          () {
            return widget.deliveryStatus == DeliveryStatus.pending
                ?
            
                ///to pick up orders **********
                ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10),
                    itemCount: driverDeliveryController
                        .pendingDeliveryList.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 12);
                    },
                    itemBuilder: (context, index) {
                      return deliveryCardWidget(
                          driverDeliveryController
                              .pendingDeliveryList[index],
                          context);
                    })
                : widget.deliveryStatus == DeliveryStatus.active
                    ?
            
                    /// pick up on way orders **********
                    ListView.separated(
                        padding: EdgeInsets.only(top: 10),
                        itemCount: driverDeliveryController
                            .activeDeliveryList.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 12);
                        },
                        itemBuilder: (context, index) {
                          return deliveryCardWidget(
                              driverDeliveryController
                                  .activeDeliveryList[index],
                              context);
                        })
                    : widget.deliveryStatus == DeliveryStatus.complete
                        ?
            
                        /// pick up completed orders **********
                        ListView.separated(
                            padding: EdgeInsets.only(
                                top: 10, left: 10, right: 10),
                            itemCount: driverDeliveryController
                                .completeDeliveryList.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 12);
                            },
                            itemBuilder: (context, index) {
                              print("hello world");
                              print(driverDeliveryController
                                  .completeDeliveryList);
                              return deliveryCardWidget(
                                  driverDeliveryController
                                      .completeDeliveryList[index],
                                  context);
                            })
                        : Container(
                          child: driverDeliveryController.activeDeliveryList.length > 0 ? Container() : Container(),
                        );
          },
        ),
      ),
    );
  }

}
