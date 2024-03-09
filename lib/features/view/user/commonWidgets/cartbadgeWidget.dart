import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/features/view/user/home/homeSubScreeen/cartScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';

class CartBadgeWidget extends StatelessWidget {
  const CartBadgeWidget({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          navigatorPush(
            context,
            CartScreen(),
            PageTransitionType.rightToLeft,
          );
        },
        child: Container(
          width: 50,
          height: 50,
          color: Colors.transparent,
          child: Stack(
            children: [
              Center(child: Icon(Ionicons.cart_outline, size: 27)),
              Positioned(
                top: 8,
                right: 5,
                child: CircleAvatar(
                  radius: 10,
                  child: Text("${cartController.myCart.length}",
                      style: TextStyle(fontSize: 12)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
