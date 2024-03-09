import 'package:delivery_app/const/fbConst.dart';
import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/features/view/user/commonWidgets/primaryButton.dart';
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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    ///getting current user's orders at the initial state
    userOrderController.getuserCurrentOrders(CurrentUser.uid.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("My Orders"),
      ),
      body: Obx(
        () => userOrderController.loading.value
            ? loadingWidget()
            : ListView.separated(
                padding: EdgeInsets.only(top: 15),
                itemCount: userOrderController.userCurrentOrders.length,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 15);
                },
                itemBuilder: (context, index) {
                  OrderModel order = userOrderController.userCurrentOrders[index];
                  return _userOrderCardWidget(order, context);
                },
              ),
      ),
    );
  }

  ///user order card widget
  Widget _userOrderCardWidget(OrderModel order, BuildContext context) {
    return GestureDetector(
      onTap: () {
        //if(order.orderStatus == OrderStatus.pending){
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                child: order.orderStatus == OrderStatus.pending ?  Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(text: "Order Status : "),
                        MyText(text: "${order.orderStatus}"),
                      ],
                    ),
                    PrimaryButton(
                      text: "Cancel Order",
                      onTap: () {
                        userOrderController.cancelAnOrder(order.orderId.toString(), _scaffoldKey);
                        Navigator.pop(context);
                      },
                      textColor: Colors.white,
                      mt: 20,
                      mr: 0,
                      ml: 0,
                    )
                  ],
                ) : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(text: "Order is already confirmed!"),
                  ],
                ),
              );
            });
        // }
      },
      child: Container(
        margin: EdgeInsets.only(right: 15, left: 15),
        padding: EdgeInsets.only(left: 13, right: 13, top: 15, bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(width: 0.2,color: Colors.grey)
        ),
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
                          color: _getOrderStatusColor(order.orderStatus.toString()),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: MyText(
                          text: order.orderStatus == OrderStatus.assignedOrder ? "Active" : order.orderStatus.toString(),
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: "${DateFormat.yMMMMd().format(order.time!)}",
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                      MyText(
                        text: "\$${order.totalAmount}",
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  //order item list
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
                        fontSize: 14,
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Color _getOrderStatusColor(String status){
    if(status == OrderStatus.pending){
      return Colors.grey;
    }else if(status == OrderStatus.assignedOrder){
      return Colors.lightBlue;
    }else if(status == OrderStatus.completed){
      return Colors.green;
    }else{
      return Colors.amber;
    }
  }
}
