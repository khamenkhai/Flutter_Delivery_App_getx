import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/features/view/user/commonWidgets/cartbadgeWidget.dart';
import 'package:delivery_app/models/cartModel.dart';
import 'package:delivery_app/models/productModel.dart';
import 'package:delivery_app/features/view/user/commonWidgets/productCardWidget.dart';
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

  ///redirect to product detail page
  navigateToProductDetail(ProductModel product) {
    userProductController.getProductById(product.productId!);
    navigatorPush(
      context,
      ProductDetailScreen(productId: product.productId!),
      PageTransitionType.rightToLeft,
    );
  }

  @override
  void initState() {
    userProductController.getProductsbyCategory(widget.category);
    super.initState();
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
                size: viewByList ? 22 : 18),
          ),
          CartBadgeWidget(context: context)
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
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: userProductController.productsByCategory.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.69,
                    ),
                    itemBuilder: (context, index) {
                      ProductModel product =
                          userProductController.productsByCategory[index];
                      return _ProductGridWidget2(product);
                    },
                  ),
      ),
    );
  }

  ///widget to show each projects with grid widet
  GestureDetector _ProductGridWidget(ProductModel product) {
    return GestureDetector(
      onTap: () {
        navigateToProductDetail(product);
      },
      child: Container(
        //padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          //border: Border.all(width: 0.5,color: Colors.grey)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                product.discount! > 0
                    ? Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: MyText(
                          text: "${product.discount}%",
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      )
                    : Container(),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Obx(
                    () => InkWell(
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
                          : Icon(IconlyLight.heart),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 7),
            Center(
              child: Hero(
                tag: product.productId!,
                child: Image.network(product.productImage!, height: 75),
              ),
            ),

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
                      Padding(
                        padding: const EdgeInsets.only(right: 10, top: 5),
                        child: InkWell(
                          onTap: () {
                            ///add product to cart
                            cartController.addToCart(
                              CartModel(id: product.productId!, quantity: 1),
                              1,
                            );
                          },
                          child: Icon(
                            Icons.shopping_bag,
                            color: Colors.black,
                          ),
                        ),
                      )
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

  ///widget to show each projects with grid widet
  GestureDetector _ProductGridWidget2(ProductModel product) {
    return GestureDetector(
      onTap: () {
        navigateToProductDetail(product);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                product.discount! > 0
                    ? Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: MyText(
                          text: "${product.discount}%",
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      )
                    : Container(),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Obx(
                    () => InkWell(
                      onTap: () {
                        userProductController.addProductToFav(
                            productId: product.productId.toString());
                      },
                      child: authController.user!.favProducts!
                              .contains(product.productId.toString())
                          ? Icon(
                              IconlyBold.heart,
                              color: Colors.red,
                              size: 18,
                            )
                          : Icon(
                              IconlyLight.heart,
                              size: 18,
                            ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 3),
            Center(
              child: Hero(
                tag: product.productId!,
                child: Image.network(product.productImage!, height: 54),
              ),
            ),

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
                        fontSize: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, top: 0),
                        child: InkWell(
                          onTap: () {
                            ///add product to cart
                            cartController.addToCart(
                              CartModel(id: product.productId!, quantity: 1),
                              1,
                            );
                          },
                          child: Icon(
                            Icons.shopping_bag,
                            color: Colors.black,
                          ),
                        ),
                      )
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
}
