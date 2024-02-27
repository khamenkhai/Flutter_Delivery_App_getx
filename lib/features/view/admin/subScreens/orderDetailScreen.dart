import 'package:delivery_app/features/view/admin/subScreens/assignDriverScreen.dart';
import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/models/cartModel.dart';
import 'package:delivery_app/models/orderModel.dart';
import 'package:delivery_app/models/productModel.dart';
import 'package:delivery_app/features/view/user/commonWidgets/primaryButton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key,required this.order});
  final OrderModel order;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Detail"),),

      body: Column(  
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Container(
            color: Colors.transparent,
            height: 300,
            width: double.infinity,
            child: Lottie.asset("assets/animations/box.json",fit:BoxFit.contain),
          ),

          Container(
            padding: EdgeInsets.only(left: 15,right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: MyText(text: "Order Id : ")),
                    Expanded(child: MyText(text: "${widget.order.orderId}")),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: MyText(text: "Order At : ")),
                    Expanded(child: MyText(text: "${DateFormat("yMMMMd").format(DateTime.now())}")),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: MyText(text: "Total Price : ")),
                    Expanded(child: MyText(text: "\$${widget.order.totalAmount}")),
                  ],
                ),

                SizedBox(height: 30),
                MyText(text: "Shipping Details",fontSize: 18,fontWeight: FontWeight.bold),

                SizedBox(height: 15),
                //customer name field
                Row(
                  children: [
                    Container(
                      width: 150,
                      child: MyText(text: "Customer Name : ")),
                    Expanded(child: MyText(text: "${widget.order.userName}")),
                  ],
                ),
                SizedBox(height: 10),
                //customer phone
                Row(
                  children: [
                    Container(
                      width: 150,
                      child: MyText(text: "Customer Ph no. : ")),
                    Expanded(child: MyText(text: "${widget.order.userPhoneNumber}")),
                  ],
                ),
                SizedBox(height: 10),
                //customer address
                Row(
                  children: [
                    Container(
                      width: 170,
                      child: MyText(text: "Customer Address : ")),
                    Expanded(child: MyText(text: "${widget.order.address}")),
                  ],
                ),

                //ordered products
                SizedBox(height: 10),
                MyText(text: "Ordered Products : "),
                SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.order.products.length,
                  itemBuilder: (context, index) {
                    CartModel cartProduct = widget.order.products[index];
                    ProductModel product = productController.products.where((p0) => p0.productId == cartProduct.id).first;
                    return MyText(text: "- ${product.name} x${cartProduct.quantity}");
                  },
                ),




                //assign delivey man button
                PrimaryButton(
                  mt: 35,
                  ml: 0,
                  mr: 0,
                  text: "Assign Driver", onTap: (){
                    navigatorPush(context, AssignDriverScreen(order: widget.order));
                  })
              ],
            ),
          ),
      

          


        ],
      ),
    
    
    
    );
  }
}