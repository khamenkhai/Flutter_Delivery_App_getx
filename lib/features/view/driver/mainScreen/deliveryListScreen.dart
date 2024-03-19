import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/features/view/driver/common_widget/deliveryCardWidget.dart';
import 'package:delivery_app/models/deliveryModel.dart';
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
        elevation: 0,
        title: Text(
            "${widget.deliveryStatus} delivery list".capitalize.toString()),
      ),
      body: Obx(
        () {
          return widget.deliveryStatus == DeliveryStatus.pending
              ?

              ////pending **********
              _deliveryListByCategory(
                  driverDeliveryController.pendingDeliveryList)

              : widget.deliveryStatus == DeliveryStatus.active
                  ?

                  /// active **********
                  _deliveryListByCategory(
                      driverDeliveryController.activeDeliveryList)

                      
                  : widget.deliveryStatus == DeliveryStatus.complete
                      ?

                      /// pick up completed orders **********
                      _deliveryListByCategory(
                          driverDeliveryController.completeDeliveryList)
                      : Container(
                          child: driverDeliveryController
                                      .activeDeliveryList.length >
                                  0
                              ? Container()
                              : Container(),
                        );
        },
      ),
    );
  }

  ListView _deliveryListByCategory(List<DeliveryModel> deliveryList) {
    return ListView.separated(
      padding: EdgeInsets.only(top: 15, left: 10, right: 10),
      itemCount: deliveryList.length,
      separatorBuilder: (context, index) {
        return SizedBox(height: 12);
      },
      itemBuilder: (context, index) {
        //print(driverDeliveryController.completeDeliveryList);
        return deliveryCardWidget(deliveryList[index], context);
      },
    );
  }
}
