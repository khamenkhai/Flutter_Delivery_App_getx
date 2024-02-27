import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/features/repositories/adminRepositories/orderRepository.dart';
import 'package:delivery_app/models/orderModel.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  OrderRepository orderRepository;

  OrderController({required this.orderRepository});

  static OrderController instance = Get.find();

  RxBool loading = false.obs;

  RxList<OrderModel> pendingOrders = <OrderModel>[].obs;
  RxList<OrderModel> assingedOrders = <OrderModel>[].obs;
  RxList<OrderModel> completedOrders = <OrderModel>[].obs;
  RxList<OrderModel> orderHistory = <OrderModel>[].obs;
  RxList<OrderModel> allOrders = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }


  //get completed Orders
 void  getOrdersByStatus(String orderStatus)async{
    loading.value = true;
    if(orderStatus == OrderStatus.pending){
      pendingOrders.bindStream(orderRepository.getOrderByStatus(OrderStatus.pending));
    }else if(orderStatus == OrderStatus.assignedOrder){
      assingedOrders.bindStream(orderRepository.getOrderByStatus(OrderStatus.assignedOrder));
    }else if(orderStatus == OrderStatus.completed){
      completedOrders.bindStream(orderRepository.getOrderByStatus(OrderStatus.completed));
    }
    else if(orderStatus == OrderStatus.history){
      orderHistory.bindStream(orderRepository.getOrderByStatus(OrderStatus.history));
    }
   
    await Future.delayed(Duration(milliseconds: 300));
    loading.value = false;
  }


  ///get alll orderes
  void getAllOrders()async{
    loading.value = true;
    allOrders.bindStream(orderRepository.getAllOrders());
    await Future.delayed(Duration(milliseconds: 300));
    loading.value = false;
  }

  ///get total sales
  getTotalSales(){
    getAllOrders();
    var totalSales = 0.0;
    allOrders.forEach((element) { 
      if(element.orderStatus == OrderStatus.completed || element.orderStatus == OrderStatus.history){
        totalSales += element.totalAmount!;
      }
    });
    return totalSales;
  }



}
