import 'package:delivery_app/features/view/admin/dashboardSubScreen/createProductScreen.dart';
import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/models/productModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AllProducts")),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigatorPush(context, CreateProductScreen());
          },
          child: Icon(Ionicons.fast_food,color: Colors.white)),
      body: Obx(
        () =>
            GridView.builder(
          itemCount: productController.products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.83),
          padding: EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
          itemBuilder: (context, index) {
            ProductModel product = productController.products[index];
            return _ProductGridWidget(product);
          },
        ),
      ),
    );
  }


  //product gird widdget
  GestureDetector _ProductGridWidget(ProductModel product) {
    return GestureDetector(
      onTap: () {
        navigatorPush(context, CreateProductScreen(product: product));
      },
      child: Container(
        //padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            Center(
                child: Hero(
                    tag: product.productId!,
                    child: Image.network(product.productImage!, height: 75))),

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

  // ignore: unused_element
  Container _discountBadge(ProductModel product) {
    return Container(
      height: 25,
      width: 100,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.5),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), bottomRight: Radius.circular(15))),
      child: Center(
          child: Text("Discount ${product.discount}%",
              style: TextStyle(fontSize: 12, color: Colors.white))),
    );
  }
}
