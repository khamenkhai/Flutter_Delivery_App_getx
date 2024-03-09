import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/const/fbConst.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //login
  Future<bool> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        print("email : ${userCredential.user!.email}");
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      showMessageSnackBar(message: e.message.toString(), context: context);
      return false;
    }
  }

  //create new account
  Future<String?> createAccount(
      {required String email,
      required String password,
      required String username,
      required BuildContext context,
      required String phoneNumber}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // ignore: unnecessary_null_comparison
      if (userCredential != null) {
    

        UserModel user = UserModel(
          profilePhoto: "",
            userId: userCredential.user!.uid,
            name: username,
            email: email,
            phoneNumber: phoneNumber,
            address: "",
            role: "",
            accountBalance: 0,
            accountPassword: "",
            moneyTranscationHistory: [],
            favProducts: []);

        await _firestore
            .collection(FirebaseConstant.userCollection)
            .doc(userCredential.user!.uid)
            .set(user.toJson());
      }
      showMessageSnackBar(message: "Account created successfully!", context: context);
      return userCredential.user!.uid;
    }on FirebaseAuthException catch (e) {
      showMessageSnackBar(message: e.message.toString(), context: context);
      return null;
    }
  }

  //sign out
  signOut() async {
    await _firebaseAuth.signOut();
  }

  //get user data by id
  Stream<UserModel> getUserDataById(String id){
    return _firestore.collection(FirebaseConstant.userCollection).doc(id).snapshots().map((event) => UserModel.fromJson(event.data() as Map<String,dynamic>));
  }

  // //upload user profile detail
  // Future<bool> uploadProfileDetail(
  //     {required String userId,
  //     required File imageFile,
  //     required String phoneNumber,
  //     required String address,
  //     }) async {
  //   try {
  //     String image = await _firestoreService.uploadImage(image: imageFile, id: userId);
  //     await _firestore.collection(Constant.userCollection).doc(userId).update({
  //       "profileImage": image,
  //       "phoneNumber": phoneNumber,
  //       "address": address,
  //     });
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }
}
