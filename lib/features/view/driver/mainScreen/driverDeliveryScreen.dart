import 'package:delivery_app/features/view/driver/common_widget/deliveryCardWidget.dart';
import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class DriverDeliveryScreen extends StatefulWidget {
  const DriverDeliveryScreen({super.key});

  @override
  State<DriverDeliveryScreen> createState() => _DriverDeliveryScreenState();
}

class _DriverDeliveryScreenState extends State<DriverDeliveryScreen> {
  @override
  void initState() {
    super.initState();
  }

  String currrentStatus = "Pending";

  List status = ["Pending", "Active", "Completed", "Cancel"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100.withOpacity(0.8),
        appBar: AppBar(
          title: Text("Deliveries"),
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 0.2,
          bottom: PreferredSize(preferredSize: Size.fromHeight(50), child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          SizedBox(width: 15),
                          ...status.map((e) => _deliveryStatusButton(
                              isCurrent: e == currrentStatus, status: e)),
                        ],
                      ),
                    ),),
        ),
        body: Obx(
          () => driverDeliveryController.loading.value
              ? loadingWidget()
              : currrentStatus == "Pending"
                  ?
              
                  ///pending**********
                  ListView.separated(
                      shrinkWrap: true,
                      padding:
                          EdgeInsets.only(top: 10, left: 10, right: 10),
                      itemCount: driverDeliveryController
                          .pendingDeliveryList.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 12);
                      },
                      itemBuilder: (context, index) {
                        return deliveryCardWidget(
                          driverDeliveryController
                              .pendingDeliveryList[index],
                          context,
                        );
                      })
                  : currrentStatus == "Active"
                      ?
              
                      /// active**********
                      ListView.separated(
                          padding: EdgeInsets.only(
                              top: 10, left: 10, right: 10),
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
                      : currrentStatus == "Completed"
                          ?
              
                          /// completed**********
                          ListView.separated(
                              padding: EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              itemCount: driverDeliveryController
                                  .completeDeliveryList.length,
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 12);
                              },
                              itemBuilder: (context, index) {
                                driverDeliveryController
                                    .addCompletedDeliveytoHistory(
                                        driverDeliveryController
                                            .completeDeliveryList[index]
                                            .deliveryId
                                            .toString());
                                return deliveryCardWidget(
                                    driverDeliveryController
                                        .completeDeliveryList[index],
                                    context);
                              })
                          : Container(),
        ));
  }

  Widget _deliveryStatusButton(
      {required bool isCurrent, required String status}) {
    return InkWell(
      borderRadius: BorderRadius.circular(7),
      onTap: () {
        currrentStatus = status;
        setState(() {
          driverDeliveryController.getDeliveriesByStatus(status);
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 12),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: isCurrent
                ? Border.all(width: 0, color: Colors.transparent)
                : Border.all(width: 0.5, color: Colors.grey),
            color: isCurrent ? Theme.of(context).primaryColor : Colors.transparent),
        child: MyText(
            text: status,
            color: isCurrent ? Colors.white : Colors.black,
            fontSize: 14,
            fontWeight: isCurrent ? FontWeight.bold : null),
      ),
    );
  }
}

