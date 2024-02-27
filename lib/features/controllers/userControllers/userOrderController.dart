import 'package:delivery_app/models/orderModel.dart';
import 'package:delivery_app/features/repositories/userRepositories/userOrderRepository.dart';
import 'package:get/get.dart';

class UserOrderController extends GetxController {
  UserOrderRepository userOrderRepository;

  UserOrderController({required this.userOrderRepository});

  static UserOrderController instance = Get.find();

  RxBool loading = false.obs;

  RxList<OrderModel> userOrders = <OrderModel>[].obs;

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
  void getUserOrders(String userId) async {
    loading.value = true;
    userOrderRepository.getCurrentOrders(userId).listen((orderList) {
      userOrders.assignAll(orderList);
    });
    await Future.delayed(Duration(milliseconds: 300));
    loading.value = false;
  }
}
