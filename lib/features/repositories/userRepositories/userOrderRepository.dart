import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/const/fbConst.dart';
import 'package:delivery_app/models/orderModel.dart';

class UserOrderRepository {
  final FirebaseFirestore firestore;

  UserOrderRepository({required this.firestore});

  ///make an order
  Future<bool> makeAnOrder(OrderModel order) async {
    try {
      await firestore
          .collection(FirebaseConstant.userOrderCollection)
          .doc(order.orderId)
          .set(order.toJson());
      return true;
    } on FirebaseException catch (e) {
      if (Constant.ENABLE_LOGS) {
        print("error at makeAnOrder : ${e.message}");
      }
      return false;
    }
  }

  //get user orders
  Stream<List<OrderModel>> getCurrentOrders(String userId) {
    return firestore
        .collection(FirebaseConstant.userOrderCollection)
        .where("userId", isEqualTo: userId)
        .orderBy("time", descending: true)
        .snapshots()
        .map((event) {
          print("data length : ${event.docs.length}");
      return event.docs
          // ignore: unnecessary_cast
          .map((e) => OrderModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    });
  }


  //get order history
  Stream<List<OrderModel>> getOrderHistory(String userId) {
    return firestore
        .collection(FirebaseConstant.userOrderCollection)
        .where("userId", isEqualTo: userId)
        .snapshots()
        .map((event) {
          print("data length : ${event.docs.length}");
      return event.docs
          // ignore: unnecessary_cast
          .map((e) => OrderModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    });
  }
}
