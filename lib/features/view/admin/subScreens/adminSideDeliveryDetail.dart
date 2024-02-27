import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/const/fbConst.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/models/deliveryModel.dart';
import 'package:delivery_app/models/orderModel.dart';
import 'package:delivery_app/models/productModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DeliveryDetail extends StatefulWidget {
  DeliveryDetail({super.key, required this.delivery});
  final DeliveryModel delivery;

  bool customerReceived = false;

  @override
  State<DeliveryDetail> createState() => _DeliveryDetailState();
}

class _DeliveryDetailState extends State<DeliveryDetail> {
  SignatureController userSignatureController = SignatureController();

  Uint8List? userSignatureFile;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Detail"),
        bottom: PreferredSize(
            preferredSize: Size(1, 1),
            child: Obx(() => deliveryController.loading.value
                ? LinearProgressIndicator()
                : Container())),
        actions: [
          widget.delivery.status == DeliveryStatus.complete
              ? Icon(Icons.check_box, color: Colors.green)
              : Container(),
          SizedBox(width: 20),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //the contaier that with padding
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                //order id
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width / 2 - 55,
                      child:
                          MyText(text: "Order Id", fontWeight: FontWeight.bold),
                    ),
                    MyText(text: ": "),
                    Expanded(child: MyText(text: "${widget.delivery.orderId}")),
                  ],
                ),

                ///delivery id
                SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width / 2 - 55,
                      child: MyText(
                          text: "Delivery Id", fontWeight: FontWeight.bold),
                    ),
                    MyText(text: ": "),
                    Expanded(
                        child: MyText(text: "${widget.delivery.deliveryId}")),
                  ],
                ),

                ///delivery id
                SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width / 2 - 55,
                      child: MyText(
                          text: "Customer Name", fontWeight: FontWeight.bold),
                    ),
                    MyText(text: ": "),
                    Expanded(
                        child: MyText(text: "${widget.delivery.customerName}")),
                  ],
                ),
                //delivery items
                SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width / 2 - 55,
                      child: MyText(text: "Items", fontWeight: FontWeight.bold),
                    ),
                    MyText(text: ": "),
                    Expanded(
                        child: FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection(
                                    FirebaseConstant.userOrderCollection)
                                .doc(widget.delivery.orderId)
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return MyText(
                                    text:
                                        "${snapshot.data!.data()!["products"].length}");
                              }
                              return Container();
                            })),
                  ],
                ),
                //status
                SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width / 2 - 55,
                      child:
                          MyText(text: "Status", fontWeight: FontWeight.bold),
                    ),
                    MyText(text: ": "),
                    Expanded(child: MyText(text: "${widget.delivery.status}")),
                  ],
                ),
                //order date
                SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width / 2 - 55,
                      child: MyText(
                          text: "Order date", fontWeight: FontWeight.bold),
                    ),
                    MyText(text: ": "),
                    Expanded(
                        child: MyText(
                            text:
                                "${DateFormat('MMMM dd, yyyy hh:mma').format(widget.delivery.orderTime!)}")),
                  ],
                ),

                //delivered date
                widget.delivery.status == DeliveryStatus.history
                    ? Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width / 2 - 55,
                              child: MyText(
                                  text: "Delivered date",
                                  fontWeight: FontWeight.bold),
                            ),
                            MyText(text: ": "),
                            Expanded(
                                child: MyText(
                                    text:
                                        "${DateFormat('MMMM dd, yyyy hh:mma').format(widget.delivery.deliveredTime!)}")),
                          ],
                        ),
                      )
                    : Container(),

                Container(
                    padding: EdgeInsets.only(top: 25, bottom: 20),
                    child: Divider()),
                //order total price
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width / 2 - 55,
                      child: MyText(
                          text: "Order total price",
                          fontWeight: FontWeight.bold),
                    ),
                    MyText(text: ": "),
                    Expanded(
                        child: MyText(text: "\$${widget.delivery.totalPrice}")),
                  ],
                ),

                Container(
                    padding: EdgeInsets.only(top: 25, bottom: 20),
                    child: Divider()),

                //address
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width / 2 - 55,
                      child:
                          MyText(text: "Address", fontWeight: FontWeight.bold),
                    ),
                    MyText(text: ": "),
                    Expanded(child: MyText(text: "${widget.delivery.address}")),
                  ],
                ),
                //customer
                SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width / 2 - 55,
                      child: MyText(
                        text: "Delivery Man",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    MyText(text: ": "),
                    Expanded(child: MyText(text: "${widget.delivery.deliveryManName}")),
                  ],
                ),

                Container(
                    padding: EdgeInsets.only(top: 25, bottom: 20),
                    child: Divider()),
              ],
            ),
          ),

          //order summary
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: MyText(text: "Order summary", fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),

          //order products
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(FirebaseConstant.userOrderCollection)
                  .doc(widget.delivery.orderId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  OrderModel order = OrderModel.fromJson(
                      snapshot.data!.data() as Map<String, dynamic>);
                  return Container(
                    height: 100,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(left: 15, right: 15),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: order.products.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 10);
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          width: 220,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(10)),
                          child: FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection(
                                      FirebaseConstant.prooductCollection)
                                  .doc(order.products[index].id)
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  ProductModel product = ProductModel.fromJson(
                                      snapshot.data!.data()
                                          as Map<String, dynamic>);
                                  return Row(
                                    children: [
                                      Container(
                                          width: 60,
                                          margin: EdgeInsets.only(right: 18),
                                          child: Image.network(
                                              product.productImage!,
                                              fit: BoxFit.cover)),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MyText(text: "${product.name}"),
                                          MyText(
                                              color: Colors.grey.shade700,
                                              text:
                                                  "Quantity : ${order.products[index].quantity}",
                                              fontSize: 14),
                                          SizedBox(height: 5),
                                          MyText(
                                              text:
                                                  "\$${order.products[index].quantity * product.currentPrice!}"),
                                        ],
                                      )
                                    ],
                                  );
                                } else {
                                  return Center(child: loadingWidget());
                                }
                              }),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(child: loadingWidget(color: Colors.black));
                }
              }),

          // widget.delivery.status != DeliveryStatus.history ? Center(
          //   child: Container(
          //     margin: EdgeInsets.only(top: 40),
          //     width: 200,
          //     height: 45,
          //     child: ElevatedButton(
          //       onPressed:(){},
          //       child: Text(
          //         widget.delivery.status == DeliveryStatus.pending
          //             ? "Start Delivery"
          //             : widget.delivery.status == DeliveryStatus.active
          //                 ? "Complete Delivery"
          //                 : "Completed",
          //         style: TextStyle(
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
          // ) : Container()
        ],
      ),
    );
  }
}
