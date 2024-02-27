import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/const/fbConst.dart';
import 'package:delivery_app/features/repositories/userRepositories/userRepository.dart';
import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/features/view/user/userSetting/userSettingSubScreens/userWallet.dart';
import 'package:delivery_app/features/view/user/commonWidgets/primaryButton.dart';
import 'package:delivery_app/features/view/user/home/homeSubScreeen/orderSuccessScreen.dart';
import 'package:delivery_app/models/orderModel.dart';
import 'package:delivery_app/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SelectAddressScreen extends StatefulWidget {
  const SelectAddressScreen({super.key});

  @override
  State<SelectAddressScreen> createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController streetNumberController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  bool cod = true;

  var _formKey = GlobalKey<FormState>();

  String orderId = generateRandomId();

  //order
  Future<bool> orderNow({required bool paid}) async {
    bool value = await userOrderController.makeAnOrder(
        order: OrderModel(
      products: cartController.myCart,
      paid: paid,
      orderId: orderId,
      totalAmount: cartController.totalAmount,
      address:
          "${streetNumberController.text} ${streetNameController.text}, ${cityController.text}",
      orderStatus: OrderStatus.pending,
      time: DateTime.now(),
      userId: CurrentUser.uid.toString(),
      userName: nameController.text,
      userPhoneNumber: int.parse(phoneController.text),
    ));
    return value;
  }
  // Future<bool> orderNow(
  //     {required double totalAmount,
  //     required List<CartModel> products,
  //     required bool paid}) async {
  //   bool value = await userOrderController.makeAnOrder(
  //     paid: paid,
  //     products: products,
  //     orderId: orderId,
  //     totalAmount: totalAmount,
  //     address:
  //         "${streetNumberController.text} ${streetNameController.text}, ${cityController.text}",
  //     userName: nameController.text,
  //     userPhoneNumber: int.parse(phoneController.text),
  //     context: context,
  //     userId: CurrentUser.uid.toString(),
  //   );
  //   return value;
  // }

  @override
  void initState() {
    if (authController.user != null) {
      nameController.text = authController.user!.name;
      phoneController.text = authController.user!.phoneNumber;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(text: "Write your address detail!", fontSize: 18),
              SizedBox(height: 30),
              Card(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _textField(
                          controller: nameController,
                          title: "Name",
                          hint: "Your name",
                        ),
                        _textField(
                          controller: phoneController,
                          title: "Phone No.",
                          hint: "Phone No.",
                        ),
                        _textField(
                          controller: streetNumberController,
                          title: "Street No.",
                          hint: "Street No.",
                        ),
                        _textField(
                          controller: streetNameController,
                          title: "Street Name",
                          hint: "Street Name",
                        ),
                        _textField(
                          controller: cityController,
                          title: "City/Town",
                          hint: "City/TownName",
                        ),
                        Row(
                          children: [
                            MyText(text: "Cash On Delivery"),
                            Checkbox(
                                value: cod,
                                onChanged: (value) {
                                  setState(() {
                                    cod = !cod;
                                  });
                                }),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              PrimaryButton(
                  text: "Proceed",
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        ///for cash on delivery
                        if (cod == true) {
                          proceedOrder(false);
                        } else {
                          ///pay now
                          UserModel admin =
                              await UserRepository().getAdminData();
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.person),
                                          SizedBox(width: 10),
                                          MyText(
                                              text: "${admin.name}"
                                                  .toUpperCase()),
                                          MyText(
                                              text: "(${admin.phoneNumber})"
                                                  .toUpperCase()),
                                          Spacer(),
                                          IconButton(
                                              onPressed: () {
                                                navigatorPush(context,
                                                    UserWalletScreen());
                                              },
                                              icon: Icon(Ionicons.wallet))
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      TextField(
                                        keyboardType: TextInputType.phone,
                                        controller: _amountController,
                                        decoration: InputDecoration(
                                            labelText: "Amount (Ks)"),
                                      ),
                                      SizedBox(height: 15),
                                      TextField(
                                        keyboardType: TextInputType.text,
                                        controller: _noteController,
                                        decoration: InputDecoration(
                                            labelText: "Add Notes (Optional)",
                                            hintText: "Please Add Notes"),
                                      ),
                                      SizedBox(height: 15),
                                      TextField(
                                        keyboardType: TextInputType.text,
                                        controller: _noteController,
                                        enabled: false,
                                        decoration: InputDecoration(
                                          hintText: "Order Id : ${orderId}",
                                        ),
                                      ),
                                      PrimaryButton(
                                        text: "Transfer",
                                        onTap: () async {
                                          bool status = await userController
                                              .transferMoney(
                                            note: _noteController.text,
                                            amount: num.parse(
                                              _amountController.text,
                                            ),
                                            orderId: orderId,
                                            receiver: admin,
                                            currentUser: authController.user!,
                                          );
                                          if (status) {
                                            proceedOrder(true);
                                          }
                                        },
                                        ml: 0,
                                        mr: 0,
                                        mt: 25,
                                      )
                                    ],
                                  ),
                                );
                              });
                        }
                      } catch (e) {
                        print("error : ${e}");
                      }
                    }
                  }),
            ],
          ),
        ),
      )),
    );
  }

  Widget _textField(
      {required String hint,
      required TextEditingController controller,
      required String title}) {
    return Row(
      children: [
        Container(width: 120, child: MyText(text: title, fontSize: 15)),
        SizedBox(width: 9),
        Expanded(
            child: TextFormField(
          controller: controller,
          validator: (value) {
            if (value!.isEmpty || value == "") {
              return "${title.toLowerCase()} required";
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
              hintText: hint, hintStyle: TextStyle(fontSize: 14)),
        ))
      ],
    );
  }

  void proceedOrder(bool paid) async {
    bool value = await orderNow(paid: paid);
    if (value) {
      cartController.clearCart();
      navigatorPushReplacement(context, OrderSuccessScreen());
    }
  }
}
