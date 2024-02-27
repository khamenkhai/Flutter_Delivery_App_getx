import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/const/fbConst.dart';
import 'package:delivery_app/models/orderModel.dart';

class OrderRepository {
  final FirebaseFirestore firestore;

  OrderRepository({required this.firestore});


  //get user orders
  Stream<List<OrderModel>> getOrderByStatus(String orderStatus) {
    return firestore
        .collection(FirebaseConstant.userOrderCollection)
        .orderBy("time",descending: true)
        .where("orderStatus",isEqualTo: orderStatus)
        .snapshots()
        .map((event) => event.docs
            // ignore: unnecessary_cast
            .map((e) => OrderModel.fromJson(e.data() as Map<String, dynamic>))
            .toList());
  }


  ///get all orders
    Stream<List<OrderModel>> getAllOrders() {
    return firestore
        .collection(FirebaseConstant.userOrderCollection)
        .orderBy("time",descending: true)
        .snapshots()
        .map((event) => event.docs
            // ignore: unnecessary_cast
            .map((e) => OrderModel.fromJson(e.data() as Map<String, dynamic>))
            .toList());
  }

}
