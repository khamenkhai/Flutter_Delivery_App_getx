import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/features/view/user/commonWidgets/productCardWidget.dart';
import 'package:delivery_app/features/view/user/home/homeSubScreeen/productDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController query = TextEditingController();

  bool _isFirst = true;

  // List<ProductModel> searchProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            ///search bar
            SliverAppBar(
              pinned: false,
              floating: true,
              expandedHeight: 130,
              title: Text("Search"),
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 57, left: 15, right: 15),
                      child: TextField(
                        controller: query,
                        onChanged: (value) async {
                          await userProductController
                              .searchProducts(query.text);
                            
                        },
                        onSubmitted: (value) async {
                          await userProductController
                              .searchProducts(query.text);
                          setState(() {
                            _isFirst = false;
                          });
                        },
                        decoration: InputDecoration(
                            hintText: "Search Products",
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            contentPadding:
                                EdgeInsets.only(top: 0, bottom: 0, left: 20),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30))),
                      ),
                    )
                  ],
                ),
              ),
            ),

            //search result list
            Obx(
              () => SliverToBoxAdapter(
                child: userProductController.loading.value
                    ? Container(
                        height: 500,
                        child: loadingWidget(),
                      )
                    :

                    //if there is not result for search
                    userProductController.getSearchProducts.length == 0 &&
                            _isFirst == false
                        ? Container(
                            height: 500,
                            child: Center(
                              child: Text("Couldn't find that product!"),
                            ),
                          )
                        : Column(
                            children: [
                              ...userProductController.getSearchProducts
                                  .map(
                                    (e) => Column(
                                      children: [
                                        ProductCardWidget(
                                            backgroundColor: Colors.white,
                                            product: e,
                                            onTap: () {
                                              //navigate to detail
                                              navigatorPush(
                                                  context,
                                                  ProductDetailScreen(
                                                      productId: e.productId
                                                          .toString()));
                                            }),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  )
                                  .toList()
                            ],
                          ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
