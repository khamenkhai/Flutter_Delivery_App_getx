import 'package:delivery_app/models/deliveryModel.dart';
import 'package:delivery_app/models/orderModel.dart';
import 'package:delivery_app/models/userModel.dart';
import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssignDriverScreen extends StatefulWidget {
  const AssignDriverScreen({super.key, required this.order});

  final OrderModel order;

  @override
  State<AssignDriverScreen> createState() => _AssignDriverScreenState();
}

class _AssignDriverScreenState extends State<AssignDriverScreen> {
  @override
  void initState() {
    driverController.getDrivers();
    super.initState();
  }

  String selectedDriverId = '';
  String selectedDriverName = '';

  //assign delivery
  assignDelivery({required BuildContext context}) async {
    bool? result = await deliveryController.assignDelivery(
        newDelivery: DeliveryModel(
      deliveryManName: selectedDriverName,
      customerName: widget.order.userName,
      customerPhone: widget.order.userPhoneNumber.toString(),
      address: widget.order.address,
      totalPrice: widget.order.totalAmount,
      orderTime: widget.order.time,
      deliveryManId: selectedDriverId,
      orderId: widget.order.orderId,
    ));
    if (result == true) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Assign Driver"),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.clear)),
          actions: [
            TextButton(
                onPressed: () {
                  //assign delivery
                  assignDelivery(context: context);
                  
                },
                child: Text("Assign"))
          ],
        ),
        body: Obx(
          () => driverController.loading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: driverController.drivers.length,
                  itemBuilder: (context, index) {
                    UserModel driver = driverController.drivers[index];
                    return ListTile(
                      leading: Icon(Icons.delivery_dining),
                      title: MyText(text: driver.name),
                      trailing: Radio(
                        value: driver.userId,
                        groupValue: selectedDriverId,
                        onChanged: (value) {
                          setState(() {
                            selectedDriverId = driver.userId;
                            selectedDriverName = driver.name.toString();
                          });
                        },
                      ),
                    );
                  },
                ),
        ));
  }
}
