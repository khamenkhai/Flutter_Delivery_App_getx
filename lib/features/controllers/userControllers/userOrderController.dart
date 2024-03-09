import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/models/orderModel.dart';
import 'package:delivery_app/features/repositories/userRepositories/userOrderRepository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserOrderController extends GetxController {
  UserOrderRepository userOrderRepository;

  UserOrderController({required this.userOrderRepository});

  static UserOrderController instance = Get.find();

  RxBool loading = false.obs;

  RxList<OrderModel> userCurrentOrders = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  //make an order
  Future<bool> makeAnOrder({required OrderModel order}) async {
    bool value = await userOrderRepository.makeAnOrder(order);

    if (value) {
      return true;
    } else {
      return false;
    }
  }

  //get user Orders
  void getuserCurrentOrders(String userId) async {
    loading.value = true;
    userOrderRepository.getCurrentOrders(userId).listen((orderList) {
      userCurrentOrders.assignAll(
        orderList.where(
          (element) =>
              element.orderStatus != OrderStatus.history &&
              element.orderStatus != OrderStatus.completed,
        ),
      );
    });
    await Future.delayed(Duration(milliseconds: 300));
    loading.value = false;
  }


  Future<bool> cancelAnOrder(String ordreId, GlobalKey<ScaffoldState> scaffoldKey)async{
    bool status = await userOrderRepository.cancelAnOrder(ordreId);

    if(status && scaffoldKey.currentContext!=null){
      ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text("Cancelled Order success!"),
          duration: Duration(seconds: 4),
        )
      );
    }
    return status;
  }
}
