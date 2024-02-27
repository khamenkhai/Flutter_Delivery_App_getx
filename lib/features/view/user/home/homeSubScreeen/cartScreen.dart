import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/models/cartModel.dart';
import 'package:delivery_app/models/productModel.dart';
import 'package:delivery_app/features/controllers/userControllers/cartController.dart';
import 'package:delivery_app/features/view/user/home/homeSubScreeen/selectAddressScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var cart = Get.put(UserCartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyCart"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              ///to clear current user cart
              cartController.clearCart();
            },
            icon: Icon(Ionicons.trash_bin_outline),
          )
        ],
      ),
      body: Obx(
        () => cartController.myCart.length < 1
            ? _emptyCartIconWidget(context)
            : Column(
                children: [
                  ///display cart item list
                  Expanded(
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                        itemCount: cartController.myCart.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10);
                        },
                        itemBuilder: (context, index) {
                          CartModel cartProduct = cartController.myCart[index];

                          ProductModel product = productController.products
                              .where((element) =>
                                  element.productId ==
                                  cartController.myCart[index].id)
                              .first;

                          return _cartProductCardWidget(product, cartProduct);
                        }),
                  ),

                  ///checkout button and total amount widgets
                  _checkOutAndTotalPriceWidget()
                ],
              ),
      ),
    );
  }

  Center _emptyCartIconWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/shopping-basket.png", height: 100),
          SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: MyText(text: "Your cart is empty"),
          ),
          SizedBox(height: 35),
        ],
      ),
    );
  }

  //widget for showing cart product with card
  GestureDetector _cartProductCardWidget(
      ProductModel product, CartModel cartProduct) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 15, bottom: 10, top: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 20),
                  blurRadius: 20,
                  color: Colors.grey.shade100)
            ]),
        child: Row(
          children: [
            ///product image
            Container(
              height: 80,
              width: 80,
              padding: EdgeInsets.all(15),
              child: Image.network(
                product.productImage!,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(text: "${product.name}"),
                MyText(
                  text: "${product.category}",
                  color: Colors.grey.shade700,
                  fontSize: 14,
                ),
                SizedBox(height: 7),
                MyText(
                  text: "\$${product.currentPrice! * cartProduct.quantity}",
                  fontSize: 17,
                )
              ],
            ),
            Spacer(),

            ///cart buttons to substract and add product to cart
            Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        cartController.removeFromCart(cartProduct);
                        setState(() {});
                      },
                      icon: Icon(Icons.remove)),
                  Text("${cartProduct.quantity}"),
                  IconButton(
                    onPressed: () {
                      cartController.addToCart(cartProduct, 1);
                      setState(() {});
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///widget for showing total pirce and checckout button
  Container _checkOutAndTotalPriceWidget() {
    return Container(
      height: 90,
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 0),
      decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText(text: "TotalPrice", fontSize: 14),
              SizedBox(height: 5),
              MyText(text: "\$${cartController.totalAmount}", fontSize: 18),
            ],
          ),
          Container(
            width: 200,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                _checkOutButtomDialog();
              },
              child: Text("Checkout"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  //modal dialog to show the checkout
  Future<dynamic> _checkOutButtomDialog() {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        )),
        builder: (context) {
          return Container(
            padding: EdgeInsets.only(top: 30, left: 25, right: 25, bottom: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                        text: "Item Total",
                        fontSize: 15,
                        color: Colors.grey.shade700),
                    MyText(
                        text: "\$${cartController.totalAmount}", fontSize: 15),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                        text: "Delivery Charge",
                        fontSize: 15,
                        color: Colors.grey.shade700),
                    MyText(text: "\$10", fontSize: 15),
                  ],
                ),
                Divider(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                        text: "Total",
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                    MyText(
                        text: "\$${cartController.totalAmount + 10}",
                        fontWeight: FontWeight.w500),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 45,
                  margin: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () async {
                      navigatorPushReplacement(context, SelectAddressScreen());
                    },
                    child: Text("Order Now"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeConstant.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                )
              ],
            ),
          );
        });
  }
}
