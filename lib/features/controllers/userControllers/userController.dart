import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/models/moneyTransactionModel.dart';
import 'package:delivery_app/models/userModel.dart';
import 'package:delivery_app/features/repositories/userRepositories/userRepository.dart';
import 'package:get/get.dart';

class UserController extends GetxController {

  static UserController instance = Get.find();  

  final UserRepository userRepository;

  UserController({required this.userRepository});

  var loading = false.obs;

   final RxList<MoneyTransactionModel> transactions = RxList<MoneyTransactionModel>();

   List<MoneyTransactionModel> get todayTransactions => transactions.where((t){
   return t.transactionTime!.year == DateTime.now().year && t.transactionTime!.month == DateTime.now().month && t.transactionTime!.day == DateTime.now().day;
   }).toList();

  @override
  void onInit() {
    super.onInit();
  }

  updateUser(UserModel user){
    userRepository.editUserProfile(user);
  }

  Stream<List<UserModel>> getUsersByPhoneNo(String phoneNumber){
    return userRepository.getUserDataByPhoneNumber(phoneNumber);
  }

  Future<UserModel> getUserDataById(String id){
    return userRepository.getUserDataById(id);
  } 



  //transfer money
  Future<bool> transferMoney({required num amount,String? note,String? orderId,required UserModel receiver,required UserModel currentUser})async{
    MoneyTransactionModel transaction = MoneyTransactionModel(
      amount: amount,
      id: generateRandomId(),
      note: note,
      receiverId: receiver.userId,
      receiverName: receiver.name,
      receiverPhone: receiver.phoneNumber,
      senderId: currentUser.userId,
      orderId: orderId,
      senderName: currentUser.name,
      senderPhone: currentUser.phoneNumber,
      transactionTime: DateTime.now(),
    );
    print("One");
    bool status = await userRepository.transferMoney(transaction: transaction);
    print("One 2");

    return status;
  }



  ///get all transactions
  getAllTransactions(){
    loading.value = false;
    transactions.bindStream(userRepository.getAllTransaction());
    loading.value = true;
  }


  ///get admin id
  Future<UserModel> getAdminData()async{
  var data = await getAdminData();
  return data;
  }


}
