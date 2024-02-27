import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/models/cartModel.dart';
import 'package:delivery_app/models/productModel.dart';
import 'package:delivery_app/features/view/user/commonWidgets/productCardWidget.dart';
import 'package:delivery_app/features/view/user/home/homeSubScreeen/cartScreen.dart';
import 'package:delivery_app/features/view/user/home/homeSubScreeen/productDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';

class ProductByCategory extends StatefulWidget {
  const ProductByCategory({super.key, required this.category});

  final String category;

  @override
  State<ProductByCategory> createState() => _ProductByCategoryState();
}

class _ProductByCategoryState extends State<ProductByCategory> {
  bool viewByList = false;

  navigateToProductDetail(ProductModel product) {
    userProductController.getProductById(product.productId!);
    navigatorPush(
      context,
      ProductDetailScreen(productId: product.productId!),
      PageTransitionType.rightToLeft,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new)),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                viewByList = !viewByList;
              });
            },
            icon: Icon(viewByList ? Ionicons.list : Ionicons.grid,
                size: viewByList ? 20 : 15),
          ),
          IconButton(
              onPressed: () {
                //to go cart
                navigatorPush(context, CartScreen());
              },
              icon: Icon(Ionicons.cart_outline))
        ],
      ),
      body: Obx(
        () => userProductController.loading.value
            ? loadingWidget()
            : viewByList
                ? ListView.separated(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    itemCount: userProductController.productsByCategory.length,
                    physics: BouncingScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 12);
                    },
                    itemBuilder: (context, index) {
                      ProductModel product =
                          userProductController.productsByCategory[index];
                      return ProductCardWidget(
                        backgroundColor: Colors.white,
                        product: product,
                        onTap: () {
                          navigateToProductDetail(product);
                        },
                      );
                    },
                  )
                : GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: userProductController.productsByCategory.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.75),
                    itemBuilder: (context, index) {
                      ProductModel product =
                          userProductController.productsByCategory[index];
                      return _ProductGridWidget(product);
                    },
                  ),
      ),
    );
  }

  GestureDetector _ProductGridWidget(ProductModel product) {
    return GestureDetector(
      onTap: () {
        navigateToProductDetail(product);
      },
      child: Container(
        //padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                product.discount! > 0
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 13, vertical: 4),
                        decoration: BoxDecoration(
                            color: ThemeConstant.primaryColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        child: MyText(
                            text: "${product.discount}%",
                            color: Colors.white,
                            fontSize: 10),
                      )
                    : Container(),
                Container(
                    padding: EdgeInsets.all(5),
                    child: Obx(() => InkWell(
                        onTap: () {
                          userProductController.addProductToFav(
                              productId: product.productId.toString());
                        },
                        child: authController.user!.favProducts!
                                .contains(product.productId.toString())
                            ? Icon(
                                IconlyBold.heart,
                                color: Colors.red,
                              )
                            : Icon(IconlyLight.heart))))
              ],
            ),
            SizedBox(height: 7),
            Center(
                child: Hero(
                    tag: product.productId!,
                    child: Image.network(product.productImage!, height: 75))),

            ///product detail
            Container(
              padding: EdgeInsets.only(left: 15, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(text: "${product.name}"),
                  MyText(
                    text: "${product.category}",
                    color: Colors.grey.shade700,
                    fontSize: 14,
                  ),
                  SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: "\$${product.currentPrice}",
                        fontSize: 17,
                      ),
                      IconButton(
                          onPressed: () {
                            ///add product to cart
                            cartController.addToCart(
                                CartModel(id: product.productId!, quantity: 1),
                                1);
                          },
                          icon: Icon(Icons.shopping_bag))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /////*************************
}
