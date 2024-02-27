// ignore_for_file: must_be_immutable
import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/models/cartModel.dart';
import 'package:delivery_app/models/productModel.dart';
import 'package:flutter/material.dart';

class ProductCardWidget extends StatelessWidget {
  ProductCardWidget({
    super.key,
    required this.product,
    required this.onTap,
    required this.backgroundColor,
  });
  final ProductModel product;
  final Function() onTap;
  Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15),
        padding: EdgeInsets.only(left: 10, right: 15, bottom: 10, top: 10),
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              padding: EdgeInsets.all(15),
              child: Hero(
                tag: product.productId!,
                child: Image.network(
                  product.productImage!,
                  fit: BoxFit.cover,
                ),
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
                  text: "\$${product.currentPrice}",
                  fontSize: 17,
                )
              ],
            ),
            Spacer(),
            CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              child: IconButton(
                onPressed: () {
                  ///add product to cart
                  cartController.addToCart(
                      CartModel(id: product.productId!, quantity: 1), 1);
                },
                icon:
                    Icon(Icons.shopping_bag, color: ThemeConstant.primaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
