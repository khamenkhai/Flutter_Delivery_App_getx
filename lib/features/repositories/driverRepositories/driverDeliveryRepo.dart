import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/const/fbConst.dart';
import 'package:delivery_app/features/repositories/storageRepository/storageRepository.dart';
import 'package:delivery_app/models/deliveryModel.dart';

class DriverDeliveryRepository {
  final FirebaseFirestore firestore;

  DriverDeliveryRepository({required this.firestore});

  Stream<List<DeliveryModel>> getDeliveryByStatus(String status) {
    return firestore
        .collection(FirebaseConstant.deliveryCollection)
        .where(
          "deliveryManId",
          isEqualTo: CurrentUser.uid,
        )
        .where("status", isEqualTo: status)
        .snapshots()
        .map((event) => event.docs.map((e) {
              // ignore: unnecessary_cast
              return DeliveryModel.fromJson(e.data() as Map<String, dynamic>);
            }).toList());
  }

  Stream<List<DeliveryModel>> getAllDeliveriesOfCurrentDriver() {
    return firestore
        .collection(FirebaseConstant.deliveryCollection)
        .where(
          "deliveryManId",
          isEqualTo: CurrentUser.uid,
        )
        .snapshots()
        .map((event) => event.docs.map((e) {
              // ignore: unnecessary_cast
              return DeliveryModel.fromJson(e.data() as Map<String, dynamic>);
            }).toList());
  }

  //
  Future<bool> setDeliveryStatus({
    required String status,
    required String deliveryId,
    Uint8List? file,
    required String orderId,
  }) async {
    try {
      if (file != null) {
        print("signatue file from repo: ${file}");
        String userSignature = await FirebaseStorageRepository.uploadImage(
            file, "DAuserSignature/${deliveryId}");
        print("user signature file : ${userSignature}");
        await firestore
            .collection(FirebaseConstant.deliveryCollection)
            .doc(deliveryId)
            .update({
          "status": status,
          "customerSignature": userSignature,
          "deliveredTime": DateTime.now().millisecondsSinceEpoch
        });

        await firestore
            .collection(FirebaseConstant.userOrderCollection)
            .doc(orderId)
            .update({"orderStatus": OrderStatus.completed});
      } else {
        await firestore
            .collection(FirebaseConstant.deliveryCollection)
            .doc(deliveryId)
            .update({
          "status": status,
        });
      }

      return true;
    } catch (e) {
      print("setDeliveryStatus(driverRepo) : ${e}");
      return false;
    }
  }

  ///add complete delivery to history
  addCompletedDeliveytoHistory(String deliveryId) async {
    DocumentSnapshot<Map<String, dynamic>> snap = await firestore
        .collection(FirebaseConstant.deliveryCollection)
        .doc(deliveryId)
        .get();

    DeliveryModel delivery = DeliveryModel.fromJson(
      snap.data() as Map<String, dynamic>,
    );
    //print("delivery from (addCompletedDeliverytoHistory) : ${delivery.address} ${delivery.deliveredTime}");

    if (delivery.deliveredTime != null &&
        delivery.deliveredTime!.isBefore(
          DateTime.now().subtract(Duration(days: 1)),
        )) {
      //print("Already passed!!!");
      await firestore
          .collection(FirebaseConstant.deliveryCollection)
          .doc(deliveryId)
          .update({
        "status": DeliveryStatus.history,
      });

      await firestore
          .collection(FirebaseConstant.userOrderCollection)
          .doc(delivery.orderId)
          .update({
        "orderStatus": DeliveryStatus.history,
      });
    }
  }
}
