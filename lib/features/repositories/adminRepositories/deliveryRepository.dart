import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/const/fbConst.dart';
import 'package:delivery_app/models/deliveryModel.dart';

class DeliveryRepository {
  final FirebaseFirestore firestore;

  DeliveryRepository({required this.firestore});

  //assign delivery
  Future<bool> assignDelivery(DeliveryModel delivery) async {
    try {
      print("testing final : ${delivery.orderId}");
      await firestore
          .collection(FirebaseConstant.userOrderCollection)
          .doc(delivery.orderId)
          .update({"orderStatus": OrderStatus.assignedOrder});

      await firestore
          .collection(FirebaseConstant.deliveryCollection)
          .doc(delivery.deliveryId)
          .set(delivery.toJson());

      return true;
    } on FirebaseException catch (e) {
      if (Constant.ENABLE_LOGS) {
        print("assignDelivery : ${e.toString()}");
        return false;
      }
      return false;
    }
  }

  //get pending delivery
  // Stream<List<DeliveryModel>> getDeliveriesByStatus(String status) {
  //   return firestore
  //       .collection(FirebaseConstant.deliveryCollection)
  //       .where("status", isEqualTo: status)
  //       .snapshots()
  //       .map((event) {
  //         event.docs.map((e) => print("data : ${e.data()}"));
  //     return event.docs
  //         .map((e) => DeliveryModel.fromJson(e.data() as Map<String, dynamic>))
  //         .toList();
  //   }
  //           // ignore: unnecessary_cast
  //           );
  // }

  Stream<List<DeliveryModel>> getDeliveriesByStatus(String status) {
    return firestore
        .collection(FirebaseConstant.deliveryCollection)
        .where("status", isEqualTo: status)
        .snapshots()
        .map((event) => event.docs
                // ignore: unnecessary_cast
                .map((e) {
              // print("Delivery data : ${e.data()}");
              return DeliveryModel.fromJson(e.data());
            }).toList());
  }


  Stream<List<DeliveryModel>> getAllDeliveries() {
    return firestore
        .collection(FirebaseConstant.deliveryCollection).orderBy('field')
        .snapshots()
        .map((event) => event.docs
                // ignore: unnecessary_cast
                .map((e) {
              // print("Delivery data : ${e.data()}");
              return DeliveryModel.fromJson(e.data());
            }).toList());
  }
}
