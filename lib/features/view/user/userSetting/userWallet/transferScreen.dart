import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/features/view/user/commonWidgets/primaryButton.dart';
import 'package:delivery_app/models/userModel.dart';
import 'package:flutter/material.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key, required this.user});
  final UserModel user;

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  TextEditingController _amountController = TextEditingController(text: "");
  TextEditingController _noteController = TextEditingController(text: " ");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transfer"),
        actions: [TextButton(onPressed: () {}, child: Text("History"))],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 10),
                  MyText(text: "${widget.user.name}".toUpperCase()),
                  MyText(text: "(${widget.user.phoneNumber})".toUpperCase()),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.phone,
                controller: _amountController,
                autofocus: true,
                decoration: InputDecoration(labelText: "Amount (Ks)"),
              ),
              SizedBox(height: 15),
              TextField(
                keyboardType: TextInputType.text,
                controller: _noteController,
                autofocus: true,
                decoration: InputDecoration(
                    labelText: "Add Notes (Optional)",
                    hintText: "Please Add Notes"),
              ),
              PrimaryButton(
                text: "Transfer",
                onTap: () async{
                  bool status = await userController.transferMoney(
                    note: _noteController.text,
                    amount: num.parse(_amountController.text),
                    receiver: widget.user,
                    currentUser: authController.user!,
                  );
                  if(status){
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                },
                ml: 0,
                mr: 0,
                mt: 25,
              )
            ],
          ),
        ),
      
      
      ),
    );
  }
}
