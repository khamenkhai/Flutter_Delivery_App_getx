import 'package:delivery_app/const/fbConst.dart';
import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/models/orderModel.dart';
import 'package:delivery_app/models/productModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserOrderScreen extends StatefulWidget {
  const UserOrderScreen({super.key});

  @override
  State<UserOrderScreen> createState() => _UserOrderScreenState();
}

class _UserOrderScreenState extends State<UserOrderScreen> {
  @override
  void initState() {
    userOrderController.getUserOrders(CurrentUser.uid.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("My Orders"),
      ),
      body: Obx(() => userOrderController.loading.value
          ? loadingWidget()
          : ListView.separated(
              padding: EdgeInsets.only(top: 15),
              itemCount: userOrderController.userOrders.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                OrderModel order = userOrderController.userOrders[index];
                return _userOrderCardWidget(order);
              })),
    );
  }

  ///user order card widget
  Container _userOrderCardWidget(OrderModel order) {
    return Container(
      margin: EdgeInsets.only(right: 15, left: 15),
      padding: EdgeInsets.only(left: 13, right: 13, top: 13, bottom: 13),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("assets/images/package.png", height: 50),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // MyText(text: "${order.orderId}",fontSize: 13,fontWeight: FontWeight.w600),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Order Id : "),
                        Text(
                          "${order.orderId}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                        decoration: BoxDecoration(
                            color: order.orderStatus == OrderStatus.completed
                                ? Colors.green
                                : Colors.blue,
                            borderRadius: BorderRadius.circular(4)),
                        child: MyText(
                            text: order.orderStatus == OrderStatus.completed
                                ? "Arrived"
                                : "Processing",
                            fontSize: 12,
                            color: Colors.white)),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                        text: "${DateFormat.yMMMMd().format(order.time!)}",
                        fontSize: 14,
                        color: ThemeConstant.secondaryTextColor),
                    MyText(
                        text: "\$${order.totalAmount}",
                        fontSize: 14,
                        color: ThemeConstant.secondaryTextColor),
                  ],
                ),
                SizedBox(height: 10),

                //order items
                ListView.builder(
                  itemCount: order.products.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    ProductModel product = productController.products
                        .where((e) => e.productId == order.products[index].id)
                        .first;
                    return MyText(
                        text:
                            "${product.name}  x${order.products[index].quantity}",
                        fontSize: 14);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
