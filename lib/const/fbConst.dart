import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseConstant{
  static final categoryCollection = "DAcategories";
  static final prooductCollection = "DAproducts";
  static final deliveryCollection = "DAdeliveries";
  static final userCollection = "DAusers";
  static final transactionCollection = "DAtransactions";

  //user's
  static final userOrderCollection = "DAuserOrders";
  // static final categoryCollection = "DAcategories";
  // static final categoryCollection = "DAcategories";

  static final firestore = FirebaseFirestore.instance;
}



class CurrentUser {
  static String? get uid {
    return FirebaseAuth.instance.currentUser?.uid;
  }
}