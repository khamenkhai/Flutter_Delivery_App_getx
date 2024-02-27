import 'package:delivery_app/models/userModel.dart';
import 'package:delivery_app/features/repositories/adminRepositories/driverRepo.dart';
import 'package:get/get.dart';

class DriverController extends GetxController {
  DriverReposiotry driverReposiotry;

  DriverController({required this.driverReposiotry});

  static DriverController instance = Get.find();

  RxBool loading = false.obs;

  RxList<UserModel> drivers = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }


  //get pending deliveries
  getDrivers(){
    loading.value = true;
    drivers.bindStream(driverReposiotry.getAllDrivers());
    loading.value = false;
  }
}
