import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/features/view/driver/common_widget/deliveryCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverHistoryScreen extends StatefulWidget {
  const DriverHistoryScreen({super.key});

  @override
  State<DriverHistoryScreen> createState() => _DriverHistoryScreenState();
}

class _DriverHistoryScreenState extends State<DriverHistoryScreen> {
  @override
  void initState() {
    driverDeliveryController.getDeliveriesByStatus(DeliveryStatus.history);
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
              itemCount: driverDeliveryController.historyList.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 12);
              },
              itemBuilder: (context, index) {
                return deliveryCardWidget(
                  driverDeliveryController.historyList[index],
                  context,
                );
              },
            );
          },
        ),
      ),
    );
  }


}
