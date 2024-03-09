import 'package:delivery_app/models/productModel.dart';
import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/models/cartModel.dart';
import 'package:delivery_app/features/view/user/commonWidgets/primaryButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => userProductController.loading.value
              ? loadingWidget()
              : _detailWidget(context),
        ),
      ),
    );
  }


  ///main product detail widget
  Widget _detailWidget(BuildContext context) {
    return StreamBuilder<ProductModel>(
      stream: userProductController.getProductById(widget.productId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ProductModel product = snapshot.data!;
          return Stack(
            children: [
              //product image
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  color:
                      getColorByCode(product.color.toString()).withOpacity(0.2),
                ),
                margin: EdgeInsets.only(bottom: 15),
                child: Container(
                  padding:
                      EdgeInsets.only(left: 50, top: 50, right: 50, bottom: 75),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 3,
                  child: Hero(
                    tag: widget.productId,
                    child: Image.network(
                      product.productImage.toString(),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              ///produc details
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3.5,
                    left: 15,
                    right: 15,
                  ),
                  padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${product.name}".toUpperCase(),
                        style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 5,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.money_dollar,
                            color: Colors.lightGreen,
                          ),

                          MyText(
                            text: "${product.currentPrice}",
                            fontSize: 17,
                          ),

                          Spacer(),

                          ///cart buttons to substract and add product to cart
                          Container(
                            padding: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _quantity > 1 ? _quantity -= 1 : 0;
                                      });
                                    },
                                    icon: Icon(Icons.remove)),
                                Text("${_quantity}"),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _quantity += 1;
                                    });
                                  },
                                  icon: Icon(Icons.add),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      MyText(
                        text: "Detail",
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "DeliOne Template is a reliable and user-friendly solution for accessing multiple services in one place. Delione is an online delivery app which allows user to get a delivery of anything they want such as grocery, food, medicine, and whatnot. ",
                        style: TextStyle(fontSize: 16, height: 1.7),
                      ),
                      SizedBox(height: 75),
                      PrimaryButton(
                        text: "Add To Cart",
                        textColor: Colors.white,
                        onTap: () {
                          //add to cart

                          if (_quantity < 1) {
                            showMessageSnackBar(
                                message: "Product quantity can't be 0!",
                                context: context);
                          } else {
                            cartController.addToCart(
                                CartModel(
                                    id: product.productId!,
                                    quantity: _quantity),
                                _quantity);
                          }
                        },
                      ),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              ),

              ///back button
              Positioned(
                top: 0,
                left: 10,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    print("hello world");
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          );
        } else {
          return loadingWidget();
        }
      },
    );
  }
}
