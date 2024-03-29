import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/models/categoryModel.dart';
import 'package:delivery_app/features/view/user/home/homeSubScreeen/cartScreen.dart';
import 'package:delivery_app/features/view/user/home/homeSubScreeen/productsByCategoryScreen.dart';
import 'package:delivery_app/features/view/user/home/homeSubScreeen/searchScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          _homeAppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Obx(() => GridView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: categoryController.categories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        CategoryModel category =
                            categoryController.categories[index];
                        return _categoryGridWidget(category, context);
                      },
                    )),
                SizedBox(height: 70),
              ],
            ),
          )
        ],
      ),
    ));
  }

  GestureDetector _categoryGridWidget2(
      CategoryModel category, BuildContext context) {
    return GestureDetector(
      onTap: () {
        userProductController.getProductsbyCategory(category.categoryName);
        navigatorPush(
            context, ProductByCategory(category: category.categoryName));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Positioned(
                left: -33,
                top: -33,
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor:
                      getColorByCode(category.colorCode).withOpacity(0.3),
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 15),
                    Image.network(
                      category.categoryImage,
                      width: 80,
                      height: 80,
                    ),
                    SizedBox(height: 13),
                    Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child:
                            MyText(text: category.categoryName, fontSize: 15)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _categoryGridWidget(
      CategoryModel category, BuildContext context) {
    return GestureDetector(
      onTap: () {
        userProductController.getProductsbyCategory(category.categoryName);
        navigatorPush(
          context,
          ProductByCategory(category: category.categoryName),
        );
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 10,
              color: Colors.grey.shade200
            )
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 100,
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: getColorByCode(category.colorCode).withOpacity(0.3),
               // image: DecorationImage(image: NetworkImage("${category.categoryImage}"),fit: BoxFit.cover)
              ),
              child: Image.network("${category.categoryImage}",fit: BoxFit.cover,),
            ),
            SizedBox(height: 13),
            FittedBox(
              child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: MyText(text: category.categoryName, fontSize: 15)),
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar _homeAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.grey.shade50,
      pinned: true,
      title: Text("Home"),
      expandedHeight: 200,
      actions: [
        IconButton(
            onPressed: () {
              //
              navigatorPush(
                  context, CartScreen(), PageTransitionType.rightToLeft);
            },
            icon: Icon(Ionicons.cart_outline))
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Colors.grey.shade50,
          padding: EdgeInsets.only(top: 10),
          margin: EdgeInsets.only(top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: "Got Delivered",
                      fontSize: 15,
                      color: Colors.grey.shade700,
                    ),
                    MyText(text: "everything you need", fontSize: 22),
                  ],
                ),
              ),
              SizedBox(height: 15),
              FakeSearchBar(),
            ],
          ),
        ),
      ),
    );
  }

  /////*************************
}

class FakeSearchBar extends StatelessWidget {
  const FakeSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //navigate to search screen
        navigatorPush(context, SearchScreen());
      },
      child: Container(
        width: double.infinity,
        height: 45,
        margin: EdgeInsets.symmetric(horizontal: 15),
        padding: EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          color: ThemeConstant.cardColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Icon(Ionicons.search),
            SizedBox(width: 15),
            MyText(text: "Search Items or Products", color: Colors.grey)
          ],
        ),
      ),
    );
  }
}
