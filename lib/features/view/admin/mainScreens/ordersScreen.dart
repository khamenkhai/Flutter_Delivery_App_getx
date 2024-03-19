import 'package:delivery_app/models/cartModel.dart';
import 'package:delivery_app/features/view/admin/subScreens/assignDriverScreen.dart';
import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/models/orderModel.dart';
import 'package:delivery_app/models/productModel.dart';
import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/features/view/user/commonWidgets/primaryButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    orderController.getOrdersByStatus(OrderStatus.pending);
    super.initState();
  }

  List status = [
    OrderStatus.pending,
    OrderStatus.assignedOrder,
    OrderStatus.completed,
  ];

  String currrentStatus = OrderStatus.pending;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text("Order"),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
            color: Colors.red,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 15, right: 0),
              decoration: BoxDecoration(color: Colors.white),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ...status.map(
                      (e) => Container(
                        margin: status.indexOf(e) == 0
                            ? EdgeInsets.only(left: 20)
                            : status.length == status.indexOf(e)
                                ? EdgeInsets.only(right: 100)
                                : EdgeInsets.only(),
                        child: _deliveryStatusButton(
                          isCurrent: e == currrentStatus,
                          status: e,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => orderController.loading.value
                  ? loadingWidget()
                  : Column(
                      children: [
                        Expanded(
                          child: currrentStatus == OrderStatus.pending
                              ? ListView.separated(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
                                  itemCount:
                                      orderController.pendingOrders.length,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: 10);
                                  },
                                  itemBuilder: (context, index) {
                                    return _orderCardWidget(
                                      orderController.pendingOrders[index],
                                      () {
                                        _assignDeliveryBottomSheet(
                                          context,
                                          order: orderController
                                              .pendingOrders[index],
                                        );
                                      },
                                      context,
                                    );
                                  },
                                )
                              : currrentStatus == OrderStatus.assignedOrder
                                  ?

                                  ///assinged orders orders **********
                                  ListView.separated(
                                      padding: EdgeInsets.only(
                                          top: 10, left: 10, right: 10),
                                      itemCount:
                                          orderController.assingedOrders.length,
                                      separatorBuilder: (context, index) {
                                        return SizedBox(height: 10);
                                      },
                                      itemBuilder: (context, index) {
                                        return _orderCardWidget(
                                          orderController.assingedOrders[index],
                                          () {
                                            _assignDeliveryBottomSheet(
                                              context,
                                              order: orderController
                                                  .assingedOrders[index],
                                            );
                                          },
                                          context,
                                        );
                                      },
                                    )
                                  : currrentStatus == OrderStatus.completed
                                      ?

                                      ///completed orders orders **********
                                      ListView.separated(
                                          padding: EdgeInsets.only(
                                              top: 10, left: 10, right: 10),
                                          itemCount: orderController
                                              .completedOrders.length,
                                          separatorBuilder: (context, index) {
                                            return SizedBox(height: 10);
                                          },
                                          itemBuilder: (context, index) {
                                            return _orderCardWidget(
                                              orderController
                                                  .completedOrders[index],
                                              () {
                                                _assignDeliveryBottomSheet(
                                                  context,
                                                  order: orderController
                                                      .completedOrders[index],
                                                );
                                              },
                                              context,
                                            );
                                          },
                                        )
                                      : Container(),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _assignDeliveryBottomSheet(BuildContext context,
      {required OrderModel order}) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Container(
                            width: 100, child: MyText(text: "Order Id : ")),
                        Expanded(child: MyText(text: "${order.orderId}")),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                            width: 100, child: MyText(text: "Order At : ")),
                        Expanded(
                            child: MyText(
                                text:
                                    "${DateFormat("yMMMMd").format(DateTime.now())}")),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                            width: 100, child: MyText(text: "Total Price : ")),
                        Expanded(child: MyText(text: "\$${order.totalAmount}")),
                      ],
                    ),

                    SizedBox(height: 30),
                    MyText(
                        text: "Shipping Details",
                        fontSize: 18,
                        fontWeight: FontWeight.bold),

                    SizedBox(height: 15),
                    //customer name field
                    Row(
                      children: [
                        Container(
                            width: 150,
                            child: MyText(text: "Customer Name : ")),
                        Expanded(child: MyText(text: "${order.userName}")),
                      ],
                    ),
                    SizedBox(height: 10),
                    //customer phone
                    Row(
                      children: [
                        Container(
                            width: 150,
                            child: MyText(text: "Customer Ph no. : ")),
                        Expanded(
                            child: MyText(text: "${order.userPhoneNumber}")),
                      ],
                    ),
                    SizedBox(height: 10),
                    //customer address
                    Row(
                      children: [
                        Container(
                            width: 170,
                            child: MyText(text: "Customer Address : ")),
                        Expanded(child: MyText(text: "${order.address}")),
                      ],
                    ),

                    SizedBox(height: 10),
                    //customer address
                    Row(
                      children: [
                        Container(
                          width: 170,
                          child: MyText(text: "Already paid : "),
                        ),
                        Expanded(child: MyText(text: "${order.paid}")),
                      ],
                    ),

                    //ordered products
                    SizedBox(height: 10),
                    MyText(text: "Ordered Products : "),
                    SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: order.products.length,
                      itemBuilder: (context, index) {
                        CartModel cartProduct = order.products[index];
                        ProductModel product = productController.products
                            .where((p0) => p0.productId == cartProduct.id)
                            .first;
                        return MyText(
                            text: "- ${product.name} x${cartProduct.quantity}");
                      },
                    ),

                    //assign delivey man button
                    SizedBox(height: 25),
                    order.orderStatus == OrderStatus.pending
                        ? PrimaryButton(
                            mt: 10,
                            ml: 0,
                            mr: 0,
                            text: "Assign Driver",
                            onTap: () {
                              navigatorPushReplacement(
                                  context, AssignDriverScreen(order: order));
                            })
                        : order.orderStatus == OrderStatus.assignedOrder
                            ? MyText(
                                text: "Order Assigned",
                                fontWeight: FontWeight.bold)
                            : order.orderStatus == OrderStatus.completed
                                ? MyText(
                                    text: "Order Delivered",
                                    fontWeight: FontWeight.bold,
                                  )
                                : Text("")
                  ],
                ),
              ),
            ],
          );
        });
  }

  Widget _deliveryStatusButton(
      {required bool isCurrent, required String status}) {
    return InkWell(
      borderRadius: BorderRadius.circular(7),
      onTap: () {
        currrentStatus = status;
        setState(() {
          orderController.getOrdersByStatus(status);
        });
        // setState(() {
        //   driverDeliveryController.getDeliveriesByStatus(status);
        // });
      },
      child: Container(
        margin: EdgeInsets.only(right: 12),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: isCurrent
                ? Border.all(width: 0, color: Colors.transparent)
                : Border.all(width: 0.5, color: Colors.grey),
            color: isCurrent
                ? Theme.of(context).primaryColor
                : Colors.transparent),
        child: MyText(
            text: status,
            color: isCurrent ? Colors.white : Colors.black,
            fontSize: 14,
            fontWeight: isCurrent ? FontWeight.bold : null),
      ),
    );
  }
}

Widget _orderCardWidget(
    OrderModel order, Function() onTap, BuildContext context) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(bottom: 1),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 75,
            width: 75,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade100,
            ),
            child: Image.asset(
              'assets/images/delivery-man.png',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            // Use Expanded to allow the text to occupy remaining space
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    MyText(text: "ID : ${order.orderId}"),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                      decoration: BoxDecoration(
                          color: getColorByOrderStatus(
                              order.orderStatus.toString()),
                          borderRadius: BorderRadius.circular(4)),
                      child: MyText(
                        text: "${order.orderStatus}",
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    Icon(Icons.person,
                        color: Theme.of(context).primaryColor, size: 20),
                    SizedBox(width: 6),
                    Text(
                      "${order.userName}",
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        color: Theme.of(context).primaryColor, size: 20),
                    SizedBox(width: 6),
                    Flexible(
                      // Use Flexible to allow text to wrap if needed
                      child: Text(
                        "${order.address}",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.access_time_outlined,
                        color: Theme.of(context).primaryColor, size: 20),
                    SizedBox(width: 6),
                    Text(
                      "${DateFormat('d MMMM ,y  hh:mm a').format(order.time!)}",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
