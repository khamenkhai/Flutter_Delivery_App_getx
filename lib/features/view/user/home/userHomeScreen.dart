import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/features/view/user/commonWidgets/cartbadgeWidget.dart';
import 'package:delivery_app/models/categoryModel.dart';
import 'package:delivery_app/features/view/user/home/homeSubScreeen/productsByCategoryScreen.dart';
import 'package:delivery_app/features/view/user/home/homeSubScreeen/searchScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

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
          ///custom app bar
          _homeAppBar(),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),

                ///show all categories with gridview
                Obx(
                  () => GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                  ),
                ),
                SizedBox(height: 70),
              ],
            ),
          )
        ],
      ),
    ));
  }

  ///category card widget to show each category
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
              color: Colors.grey.shade100,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 100,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: getColorByCode(category.colorCode).withOpacity(0.3),
              ),
              child: Image.network(
                "${category.categoryImage}",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 9),
            FittedBox(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: MyText(
                  text: category.categoryName,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///cusom sliver appbar
  SliverAppBar _homeAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.grey.shade50,
      pinned: true,
      title: Text("Home"),
      expandedHeight: 200,
      actions: [
        CartBadgeWidget(context: context)
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
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Icon(
              Ionicons.search,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(width: 15),
            MyText(text: "Search Items or Products", color: Colors.grey)
          ],
        ),
      ),
    );
  }
}
