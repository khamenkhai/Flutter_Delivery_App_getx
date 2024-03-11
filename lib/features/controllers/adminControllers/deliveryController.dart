import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/features/repositories/adminRepositories/deliveryRepository.dart';
import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/models/deliveryModel.dart';
import 'package:get/get.dart';

class DeliveryController extends GetxController {
  DeliveryRepository deliveryRepository;

  DeliveryController({required this.deliveryRepository});

  static DeliveryController instance = Get.find();

  RxBool loading = true.obs;

  RxList<DeliveryModel> pendingDeliveries = <DeliveryModel>[].obs;
  RxList<DeliveryModel> onWayDeliveries = <DeliveryModel>[].obs;
  RxList<DeliveryModel> completedDeliveries = <DeliveryModel>[].obs;
  RxList<DeliveryModel> allDeliveries = <DeliveryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  //assign delivery to delivery man
  Future<bool?> assignDelivery({required DeliveryModel newDelivery}) async {

    try{
      String deliveryId = generateRandomId();
    
    DeliveryModel delivery = DeliveryModel(
      deliveryManName: newDelivery.deliveryManName,
      deliveryId: deliveryId,
      totalPrice: newDelivery.totalPrice,
      orderId: newDelivery.orderId,
      address: newDelivery.address,
      deliveryManId: newDelivery.deliveryManId,
      customerSignature: "",
      status: DeliveryStatus.pending,
      customerName: newDelivery.customerName,
      customerPhone: newDelivery.customerPhone,
      orderTime: DateTime.now(),
      customerPaid: newDelivery.customerPaid
    );
    
    bool result = await deliveryRepository.assignDelivery(delivery);
    return result;
    }catch(e){
      if(Constant.ENABLE_LOGS){
        print("assignDelivery controller : ${e}");
      }
      return false;
    }
  }

  // //assign delivery to delivery man
  // Future<bool> assignDelivery(
  //     {required String deliveryManId,
  //     required String deliveryManName,
  //     required String orderId,
  //     required String customerName,
  //     required String customerPhone,
  //     required DateTime time,
  //     required num totalPrice,
  //     required String address
  //     }) async {
  //   String deliveryId = generateRandomId();
  //   DeliveryModel delivery = DeliveryModel(
  //     deliveryManName: deliveryManName,
  //       deliveryId: deliveryId,
  //       totalPrice: totalPrice,
  //       orderId: orderId,
  //       address: address,
  //       deliveryManId: deliveryManId,
  //       customerSignature: "",
  //       status: DeliveryStatus.pending,
  //       customerName: customerName,
  //       customerPhone: customerPhone,
  //       orderTime: DateTime.now());
  //   bool result = await deliveryRepository.assignDelivery(delivery);
  //   return result;
  // }

  //get pending deliveries
  getDeliveriesByStatus(String status) async {
    loading.value = true;
    if (status == DeliveryStatus.pending) {
      pendingDeliveries
          .bindStream(deliveryRepository.getDeliveriesByStatus(status));
      print("pending deliveries : ${pendingDeliveries}");
    } else if (status == DeliveryStatus.active) {
      onWayDeliveries
          .bindStream(deliveryRepository.getDeliveriesByStatus(status));
      print("onWayDeliveries : ${onWayDeliveries}");
    } else if (status == DeliveryStatus.complete) {
      completedDeliveries
          .bindStream(deliveryRepository.getDeliveriesByStatus(status));
      print("completedDeliveries delveries : ${completedDeliveries}");
    }

    await Future.delayed(Duration(milliseconds: 300));

    loading.value = false;
  }


  ///get all deliveries
  getAllDeliveries()async{
    loading.value = true;
    allDeliveries.bindStream(deliveryRepository.getAllDeliveries());
    await Future.delayed(Duration(milliseconds: 300));
    loading.value = false;
  }
}
