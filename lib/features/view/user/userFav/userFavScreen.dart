import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/features/view/user/home/homeSubScreeen/productDetailScreen.dart';
import 'package:delivery_app/models/productModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';

class UserFavScreen extends StatefulWidget {
  const UserFavScreen({super.key});

  @override
  State<UserFavScreen> createState() => _UserFavScreenState();
}

class _UserFavScreenState extends State<UserFavScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourites"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            ///display user fav products with grid view
            Obx(
              () => GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: authController.user?.favProducts?.length ?? 0,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.8),
                itemBuilder: (context, index) {
                  String productId = authController.user!.favProducts![index];
                  return StreamBuilder<ProductModel>(
                    stream: userProductController.getProductById(productId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return _ProductGridWidget(snapshot.data!);
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  ///fav product grid  widget
  GestureDetector _ProductGridWidget(ProductModel product) {
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 13, vertical: 4),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade900,
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
            SizedBox(height: 10),
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



  ///redirect to product detail page
  navigateToProductDetail(ProductModel product) {
    userProductController.getProductById(product.productId!);
    navigatorPush(
      context,
      ProductDetailScreen(productId: product.productId!),
      PageTransitionType.rightToLeft,
    );
  }
}
