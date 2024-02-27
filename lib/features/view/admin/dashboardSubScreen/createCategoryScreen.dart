import 'dart:typed_data';
import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/models/categoryModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class CreateCategoryScreen extends StatefulWidget {
  const CreateCategoryScreen({super.key,this.category});
  final CategoryModel? category;

  @override
  State<CreateCategoryScreen> createState() => _CreateCategoryScreenState();
}

class _CreateCategoryScreenState extends State<CreateCategoryScreen> {
  Uint8List? _categoryImage;

  var selectedColor = colorMap.keys.first;

  TextEditingController _categoryName = TextEditingController();
  TextEditingController _selectedColorController = TextEditingController();

  //select category image
  pickCategoryImage(bool isCamera) async {
    _categoryImage = await pickImage(isCamera);
    Navigator.pop(context);
    setState(() {});
  }

  //post category
  createCategory() async {
    if (_categoryImage == null) {
      showMessageSnackBar(message: "Image can't be empty", context: context);
    } else {
      bool value = await categoryController.createNewCategory(
        categoryName: _categoryName.text,
        colorcode: _selectedColorController.text,
        photo: _categoryImage!,
      );
      if (value) {
        Navigator.pop(context);
      }
    }
  }

  //to show alert dialog
  void pickImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () => pickCategoryImage(true),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Camera"),
                    ],
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () => pickCategoryImage(false),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Gallery"),
                    ],
                  ),
                ),
                Divider(height: 0),
                ListTile(
                  onTap: () => Navigator.pop(context),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Cancel"),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create Category"),
          actions: [
            TextButton(
                onPressed: () {
                  createCategory();
                },
                child: Text("Save")),
          ],
        ),
        body: Obx(
          () => categoryController.loading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            SizedBox(height: 15),
                            Container(
                              margin: EdgeInsets.only(top: 15, bottom: 10),
                              height: 135,
                              width: 150,
                              padding: EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.shade200),
                              child: _categoryImage != null
                                  ? Image.memory(_categoryImage!)
                                  : Icon(Ionicons.camera_sharp,
                                      size: 60, color: Colors.grey),
                            ),
                            _categoryImage == null
                                ? TextButton.icon(
                                    onPressed: () {
                                      pickImageDialog();
                                    },
                                    icon: Icon(Ionicons.camera),
                                    label: Text("Add a photo"))
                                : TextButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        _categoryImage = null;
                                      });
                                    },
                                    icon: Icon(Ionicons.trash),
                                    label: Text("Remove photo")),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),

                      ////
                      Container(
                        padding: EdgeInsets.only(left: 35,right: 35),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 35),
                            MyText(text: 'CATEGORY TITLE'),
                            SizedBox(height: 10),
                            TextField(
                              controller: _categoryName,
                              decoration: InputDecoration(
                                  hintText: "Enter category name",
                                  filled: true,  
                                  fillColor: Colors.grey.shade100,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8)
                                  ),),
                            ),
                            SizedBox(height: 30),
                            MyText(text: 'CATEGORY THEME'),
                            SizedBox(height: 10),
                            TextField(
                              readOnly: true,
                              controller: _selectedColorController,
                              decoration: InputDecoration(
                                  hintText: "Select category theme color",
                                  filled: true,  
                                  fillColor: Colors.grey.shade100,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  suffixIcon: DropdownButton(
                                      elevation: 0,
                                      hint: Text(""),
                                      value: null,
                                      items: colorMap.keys
                                          .map((e) => DropdownMenuItem(
                                              child: Text("${e}"), value: e))
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedColor = value.toString();
                                          _selectedColorController.text =
                                              selectedColor;
                                        });
                                      })),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
        ));
  }
}
