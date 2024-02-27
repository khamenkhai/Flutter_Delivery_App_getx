import 'dart:typed_data';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/models/productModel.dart';
import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key, this.product});

  final ProductModel? product;

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  Uint8List? productImage;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _productName = TextEditingController();
  TextEditingController _selectedColor = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  //select Product image
  pickProductImage(bool isCamera) async {
    productImage = await pickImage(isCamera);
    Navigator.pop(context);
    setState(() {});
  }

  //post Product
  createProduct() async {
    if (productImage == null) {
      showMessageSnackBar(message: "Image can't be empty", context: context);
    } else {
      bool value = await productController.createNewProduct(
        description: descriptionController.text,
        category: _categoryController.text,
        color: _selectedColor.text,
        name: _productName.text,
        photo: productImage!,
        price: double.parse(_priceController.text),
        quantity: int.parse(_quantityController.text),
        
      );
      if (value) {
        Navigator.pop(context);
      }
    }
  }

  editProduct() async {
    bool value = await productController.editProduct(
      product: ProductModel(
        description: descriptionController.text,
        category: _categoryController.text,
        color: _selectedColor.text,
        name: _productName.text,
        currentPrice: double.parse(_priceController.text),
        quantity: int.parse(_quantityController.text),
        //discount: double.parse(_discountController.text),
        productId: widget.product!.productId
      ),
    );
    if (value) {
      Navigator.pop(context);
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
                  onTap: () => pickProductImage(true),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Camera"),
                    ],
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () => pickProductImage(false),
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
  void initState() {
    if (widget.product != null) {
      _productName.text = widget.product!.name!;
      _categoryController.text = widget.product!.category!;
      _priceController.text = widget.product!.currentPrice!.toString();
      _quantityController.text = widget.product!.quantity!.toString();
      _selectedColor.text = widget.product!.color!.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.product == null ? "Add New Product" : "Edit Product"),
        actions: [
          TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (widget.product == null) {
                    createProduct();
                  } else {
                    //update product
                    editProduct();
                  }
                }
              },
              child: Text(widget.product == null ? "Create" : "Save")),
          SizedBox(width: 10),
        ],
      ),
      body:
          //  Obx(
          //   () => productController.loading.value
          //       ? Center(
          //           child: CircularProgressIndicator(),
          //         )
          //       :
          SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Obx(() => productController.loading.value
                  ? LinearProgressIndicator()
                  : Container()),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //add photo field
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //show product image is the current situation is eidt
                          widget.product != null
                              ? Container(
                                  margin: EdgeInsets.only(top: 15, bottom: 10),
                                  padding: EdgeInsets.all(10),
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey.shade200),
                                  child: Image.network(
                                      widget.product!.productImage!,
                                      fit: BoxFit.cover),
                                )
                              : Container(
                                  margin: EdgeInsets.only(top: 15, bottom: 10),
                                  padding: EdgeInsets.all(10),
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey.shade200),
                                  child: productImage != null
                                      ? Image.memory(productImage!,
                                          fit: BoxFit.cover)
                                      : Icon(Ionicons.camera_sharp,
                                          size: 60, color: Colors.grey),
                                ),
                          productImage == null
                              ? TextButton.icon(
                                  onPressed: () {
                                    pickImageDialog();
                                  },
                                  icon: Icon(Ionicons.camera),
                                  label: Text("Add a photo"))
                              : TextButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      productImage = null;
                                    });
                                  },
                                  icon: Icon(Ionicons.trash),
                                  label: Text("Remove photo")),
                        ],
                      ),
                    ),

                    ////
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                            text: "Product Info",
                            fontSize: 18,
                            fontWeight: FontWeight.bold),

                        ///product name
                        SizedBox(height: 20),
                        MyText(text: 'Product Name', fontSize: 16),
                        SizedBox(height: 10),
                        TextField(
                          controller: _productName,
                          decoration: InputDecoration(
                            hintText: "Enter product name",
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),

                        ///category
                        SizedBox(height: 20),
                        MyText(text: 'Category', fontSize: 16),
                        SizedBox(height: 10),
                        TextFormField(
                          readOnly: false,
                          controller: _categoryController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == "" || value!.isEmpty) {
                              return "Category required!";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "Select Category",
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8)),
                              suffixIcon: Obx(
                                () => DropdownButton(
                                  elevation: 0,
                                  underline: Container(),
                                  hint: Text(""),
                                  // value: "",
                                  items: categoryController.categories
                                      .map((element) => DropdownMenuItem(
                                          child: Text(
                                              element.categoryName.toString()),
                                          value: element.categoryName))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _categoryController.text =
                                          value.toString();
                                    });
                                  },
                                ),
                              )),
                        ),

                        ///product price
                        SizedBox(height: 20),
                        MyText(text: 'Product Price', fontSize: 16),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _priceController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == "" || value!.isEmpty) {
                              return "Product price required!";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Enter Product Price",
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),

                        ///dicount price
                        SizedBox(height: 20),
                        MyText(text: 'Discount', fontSize: 16),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "",
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),

                        ///product quantity
                        SizedBox(height: 20),
                        MyText(text: 'Product Quantity', fontSize: 16),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _quantityController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == "" || value!.isEmpty) {
                              return "Product quantity required!";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Enter Product Quantity",
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),

                        ///product color
                        SizedBox(height: 20),
                        MyText(text: 'Product Color', fontSize: 16),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _selectedColor,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == "" || value!.isEmpty) {
                              return "Product color required!";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "Select Product Color",
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8)),
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
                                      _selectedColor.text = value.toString();
                                    });
                                  })),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
