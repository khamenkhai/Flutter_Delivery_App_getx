import 'package:delivery_app/const/fbConst.dart';
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
    getUserOrders(CurrentUser.uid.toString());
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
  // Future<bool> makeAnOrder(
  //     {required List<CartModel> products,
  //     required double totalAmount,
  //     required String userName,
  //     required String orderId,
  //     required BuildContext context,
  //     required String address,
  //     required int userPhoneNumber,
  //     required bool paid,
  //     required String userId}) async {

  //   OrderModel order = OrderModel(
  //     paid: paid,
  //     userPhoneNumber: userPhoneNumber,
  //     orderId: orderId,
  //     userName: userName,
  //     userId: userId,
  //     time: DateTime.now(),
  //     orderStatus: OrderStatus.pending,
  //     totalAmount: totalAmount,
  //     products: products,
  //     address: address,
  //   );

  //   bool value = await userOrderRepository.makeAnOrder(order);
  //   if(value){
  //     return true;
  //   }else{
  //     return false;
  //   }
  // }

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
