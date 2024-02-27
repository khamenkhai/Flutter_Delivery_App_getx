import 'dart:typed_data';
import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/models/deliveryModel.dart';
import 'package:delivery_app/features/repositories/driverRepositories/driverDeliveryRepo.dart';
import 'package:get/get.dart';

class DriverDeliveryController extends GetxController {
  DriverDeliveryRepository driverDeliveryRepository;

  DriverDeliveryController({required this.driverDeliveryRepository});

  static DriverDeliveryController instance = Get.find();

  RxBool loading = false.obs;

  RxList<DeliveryModel> pendingDeliveryList = <DeliveryModel>[].obs;
  RxList<DeliveryModel> activeDeliveryList = <DeliveryModel>[].obs;
  RxList<DeliveryModel> completeDeliveryList = <DeliveryModel>[].obs;
  RxList<DeliveryModel> historyList = <DeliveryModel>[].obs;
  RxList<DeliveryModel> deliveryList = <DeliveryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  getDeliveriesByStatus(String status) {
    if (status == DeliveryStatus.pending) {
      pendingDeliveryList
          .bindStream(driverDeliveryRepository.getDeliveryByStatus(status));
      print("getting  ${status} : ${pendingDeliveryList} :::");
    } else if (status == DeliveryStatus.active) {
      activeDeliveryList
          .bindStream(driverDeliveryRepository.getDeliveryByStatus(status));
      print("getting  ${status} : ${activeDeliveryList} :::");
    } else if (status == DeliveryStatus.complete) {
      completeDeliveryList
          .bindStream(driverDeliveryRepository.getDeliveryByStatus(status));
      print("getting  ${status}: ${completeDeliveryList} :::");
    }
     else if (status == DeliveryStatus.history) {
      historyList
          .bindStream(driverDeliveryRepository.getDeliveryByStatus(status));
      print("getting  ${status}: ${completeDeliveryList} :::");
    }
  }

  void getDeliveryList() {
    deliveryList.bindStream(
      driverDeliveryRepository.getAllDeliveriesOfCurrentDriver(),
    );
  }

  Future<bool> setDeliveryStatus({
    required String status,
    required String deliveryId,
    Uint8List? file,
    required String orderId,
  }) async {
    loading.value = true;

    bool resultStatus = await driverDeliveryRepository.setDeliveryStatus(
      orderId: orderId,
      status: status,
      deliveryId: deliveryId,
      file: file,
    );

    loading.value = false;
    return resultStatus;
  }

  void addCompletedDeliveytoHistory(String deliveryId) {
    driverDeliveryRepository.addCompletedDeliveytoHistory(deliveryId);
  }
}
