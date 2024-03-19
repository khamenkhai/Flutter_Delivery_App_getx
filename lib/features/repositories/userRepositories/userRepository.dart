// ignore_for_file: unnecessary_cast
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/const/fbConst.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/models/moneyTransactionModel.dart';
import 'package:delivery_app/models/userModel.dart';

class UserRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // UserRepository({required this.firestore});
  CollectionReference get _userCollection =>
      firestore.collection(FirebaseConstant.userCollection);

  Future<bool> editUserProfile(UserModel user) async {
    try {
      final userCollection =
          firestore.collection(FirebaseConstant.userCollection);

      Map<String, dynamic> userInformation = Map();

      // ignore: unnecessary_null_comparison
      if (user.name != "" && user.name != null)
        userInformation['name'] = user.name;
      // ignore: unnecessary_null_comparison
      if (user.email != "" && user.email != null)
        userInformation['email'] = user.email;
      // ignore: unnecessary_null_comparison
      if (user.profilePhoto != "" && user.profilePhoto != null)
        userInformation['profilePhoto'] = user.profilePhoto;
      // ignore: unnecessary_null_comparison
      if (user.phoneNumber != "" && user.phoneNumber != null)
        userInformation['phoneNumber'] = user.phoneNumber;

      bool status = await userCollection
          .doc(user.userId)
          .update(userInformation)
          .then((value) {
        return true;
      });
      return status;
    } catch (e) {
      return false;
    }
  }

  //get userdata list by phone number
  Stream<List<UserModel>> getUserDataByPhoneNumber(String phoneNumber) {
    return firestore
        .collection(FirebaseConstant.userCollection)
        .where("phoneNumber", isEqualTo: phoneNumber)
        .snapshots()
        .map((event) {
      return event.docs.map((e) => UserModel.fromJson(e.data())).toList();
    });
  }

  Future<UserModel> getUserDataById(String id) async {
    DocumentSnapshot<Map<String, dynamic>> data = await firestore
        .collection(FirebaseConstant.userCollection)
        .doc(id)
        .get();
    UserModel userModel =
        UserModel.fromJson(data.data() as Map<String, dynamic>);
    return userModel;
  }

  Future<bool> checkIfThereisEnoughMoney(num amount)async{

      final currentUser = await _userCollection.doc(CurrentUser.uid).get();
      num currentUserBalance = currentUser["accountBalance"];

      if(currentUserBalance > amount){
        return true;
      }else{
        return false;
      }

  }

  Future<bool> transferMoney({
    required MoneyTransactionModel transaction,
  }) async {
    String transactionId = generateRandomId();

    print("two");

    try {
      final currentUser = await _userCollection.doc(CurrentUser.uid).get();

      print("three");

      num currentUserBalance = currentUser["accountBalance"];

      print("four");

      if (currentUserBalance >= transaction.amount!) {
        //send to reciever
        await _userCollection
            .doc(CurrentUser.uid)
            .collection(FirebaseConstant.transactionCollection)
            .doc(transactionId)
            .set(
              transaction
                  .copyWith(
                    amount: transaction.amount!,
                    transactionType: TransactionType.send,
                  )
                  .toMap(),
            );

        print("five");

        await _userCollection.doc(CurrentUser.uid).update({
          "accountBalance": currentUserBalance - transaction.amount!,
        });

        print("six");

        //received receive from sender
        final receiverUser =
            await _userCollection.doc(transaction.receiverId).get();

        print("seven");

        num receiverUserBalance = receiverUser["accountBalance"];

        print("eight");

        await _userCollection
            .doc(transaction.receiverId)
            .collection(FirebaseConstant.transactionCollection)
            .doc(transactionId)
            .set(
              transaction
                  .copyWith(
                      amount: transaction.amount!,
                      transactionType: TransactionType.receive)
                  .toMap(),
            );

        print("nine");

        await _userCollection.doc(transaction.receiverId).update({
          "accountBalance": receiverUserBalance + transaction.amount!,
        });

        print("ten");

        return true;
      }else{
        return false;
      }
    } catch (e) {
      print("e - transferMoney : ${e}");
      return false;
    }
  }

  Future<bool> transferMoneyddd(
      {required MoneyTransactionModel transaction}) async {
    MoneyTransactionModel userTransaction =
        transaction.copyWith(transactionType: TransactionType.send);
    MoneyTransactionModel receiverTransaction =
        transaction.copyWith(transactionType: TransactionType.receive);

    try {
      final currentUser = await _userCollection.doc(CurrentUser.uid).get();

      int currentUserBalance = currentUser["accountBalance"];

      await _userCollection.doc(CurrentUser.uid).update({
        "accountBalance": currentUserBalance - transaction.amount!,
        "moneyTranscationHistory":
            FieldValue.arrayUnion([userTransaction.toMap()])
      });

      final receiverUser =
          await _userCollection.doc(transaction.receiverId).get();
      int customerBalance = receiverUser["accountBalance"];
      await _userCollection.doc(transaction.receiverId).update({
        "accountBalance": customerBalance + transaction.amount!,
        "moneyTranscationHistory":
            FieldValue.arrayUnion([receiverTransaction.toMap()])
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  ///get all transaction history
  Stream<List<MoneyTransactionModel>> getAllTransaction() {
    return _userCollection
        .doc(CurrentUser.uid)
        .collection(FirebaseConstant.transactionCollection)
        .snapshots()
        .map((event) {
      return event.docs.map((e) {
        return MoneyTransactionModel.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  //get admin data
  Future<UserModel> getAdminData() async {
    QuerySnapshot<Map<String, dynamic>> data = await firestore
        .collection(FirebaseConstant.userCollection)
        .where("role", isEqualTo: "admin")
        .get();
    UserModel admin =
        UserModel.fromJson(data.docs.first.data() as Map<String, dynamic>);
    print("getadmindata : ${admin.name}");
    return admin;
  }
}
