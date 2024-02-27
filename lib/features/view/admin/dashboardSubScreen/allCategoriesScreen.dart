import 'package:delivery_app/features/view/admin/dashboardSubScreen/createCategoryScreen.dart';
import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/models/categoryModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(title: Text("Categories")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigatorPush(context, CreateCategoryScreen());
        },
        child: Icon(Icons.add,color: Colors.white),
      ),
      body: Obx(() => GridView.builder(
            itemCount: categoryController.categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 0.99,
            ),
            padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
            itemBuilder: (context, index) {
              CategoryModel category = categoryController.categories[index];
              return InkWell(
                onTap: () {
                  navigatorPush(
                      context, CreateCategoryScreen(category: category));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      //color: getColorByCode(categoryController.categories[index].colorCode).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 25),
                          Image.network(
                            category.categoryImage,
                            width: 85,
                            height: 85,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 18),
                          Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: MyText(
                                  text: category.categoryName, fontSize: 15)),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}
