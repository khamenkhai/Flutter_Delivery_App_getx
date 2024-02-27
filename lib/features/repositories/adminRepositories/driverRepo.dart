// ignore_for_file: unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/const/fbConst.dart';
import 'package:delivery_app/models/userModel.dart';

class DriverReposiotry {
  final FirebaseFirestore firestore;

  DriverReposiotry({required this.firestore});

  //get all drivers
  Stream<List<UserModel>> getAllDrivers() {
    return firestore
        .collection(FirebaseConstant.userCollection)
        .where("role", isEqualTo: "driver")
        .snapshots()
        .map((event) => event.docs.map((e) => UserModel.fromJson(e.data() as Map<String,dynamic>)).toList());
  }
}
