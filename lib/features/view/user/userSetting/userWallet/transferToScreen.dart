import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/features/view/user/commonWidgets/primaryButton.dart';
import 'package:delivery_app/features/view/user/userSetting/userWallet/transferScreen.dart';
import 'package:delivery_app/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferToScreen extends StatefulWidget {
  const TransferToScreen({super.key});

  @override
  State<TransferToScreen> createState() => _TransferToScreenState();
}

class _TransferToScreenState extends State<TransferToScreen> {
  TextEditingController _phoneNoController = TextEditingController(text: "09");

  String? _selectedUserId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transfer To"),
        actions: [TextButton(onPressed: () {}, child: Text("History"))],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.phone,
                controller: _phoneNoController,
                onChanged: (value) {
                  setState(() {
                    userController.getUsersByPhoneNo(_phoneNoController.text);
                  });
                },
                onSubmitted: (value) {
                  setState(() {
                    userController.getUsersByPhoneNo(_phoneNoController.text);
                  });
                },
                decoration:
                    InputDecoration(labelText: "Transfer to Phone Number"),
              ),
              Obx(() => userController.loading.value
                  ? Container()
                  : StreamBuilder<List<UserModel>>(
                      stream: userController.getUsersByPhoneNo(
                        _phoneNoController.text,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data!.length > 0
                              ? Container(
                                  child: ListView.builder(
                                    padding: EdgeInsets.only(top: 15),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        child: Container(
                                          child: ListTile(
                                            leading: Radio(
                                                value: snapshot
                                                    .data![index].userId,
                                                groupValue: _selectedUserId,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedUserId = value;
                                                  });
                                                }),
                                            title: Text(
                                              "${snapshot.data![index].name}",
                                            ),
                                            subtitle: Text(
                                                "${snapshot.data![index].email}"),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : Container();
                        } else {
                          return userController.loading.value
                              ? loadingWidget()
                              : Text("No data");
                        }
                      })),
              PrimaryButton(
                text: "Next",
                onTap: () async {
                  UserModel? user;
                  if (_selectedUserId != null) {
                    user =
                        await userController.getUserDataById(_selectedUserId!);
                    navigatorPush(context, TransferScreen(user: user));
                  } else {
                    showMessageSnackBar(
                        message: "You have to select user!", context: context);
                  }
                },
                ml: 0,
                mr: 0,
                mt: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
