import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/features/view/admin/widgets/mytextwidget.dart';
import 'package:delivery_app/features/view/user/userSetting/userWallet/transactionHistoryScreen.dart';
import 'package:delivery_app/features/view/user/userSetting/userWallet/transferToScreen.dart';
import 'package:delivery_app/models/moneyTransactionModel.dart';
import 'package:delivery_app/models/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserWalletScreen extends StatefulWidget {
  const UserWalletScreen({super.key});

  @override
  State<UserWalletScreen> createState() => _UserWalletScreenState();
}

class _UserWalletScreenState extends State<UserWalletScreen> {
  @override
  void initState() {
    userController.getAllTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Wallet")),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Obx(() {
            UserModel? user = authController.user;
            return Container(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 35),

                  //top form
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(text: "Balance"),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: MyText(text: "\$", fontSize: 23),
                              ),
                              MyText(
                                  text: "${user?.accountBalance}",
                                  fontSize: 35),
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: MyText(text: ".00", fontSize: 18),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),

                  //bottom form
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //-----
                      Column(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: Icon(Icons.qr_code_scanner_sharp,
                                color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          MyText(text: "Scan")
                        ],
                      ),
                      //-----
                      Column(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: Icon(Icons.qr_code, color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          MyText(text: "Receive")
                        ],
                      ),
                      //-----
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          navigatorPush(context, TransferToScreen());
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Icon(Icons.attach_money_sharp,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 10),
                            MyText(text: "Transfer")
                          ],
                        ),
                      ),
                      //-----
                      InkWell(
                        onTap: () {
                          navigatorPush(context, TransactionHistoryScreen());
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Icon(Icons.history, color: Colors.white),
                            ),
                            SizedBox(height: 10),
                            MyText(text: "History")
                          ],
                        ),
                      ),
                    ],
                  ),

                  //
                  SizedBox(height: 50),
                  MyText(text: "Today", fontSize: 20),
                  SizedBox(height: 10),

                  Obx(() {
                    return ListView.separated(
                      itemCount: userController.todayTransactions.length,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10);
                      },
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        MoneyTransactionModel transaction =
                            userController.todayTransactions[index];
                        return _transactionWidget(transaction);
                      },
                    );
                  })
                ],
              ),
            );
          })),
    );
  }

  Container _transactionWidget(MoneyTransactionModel transaction) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Icon(
            CupertinoIcons.money_dollar_circle_fill,
            color: Theme.of(context).primaryColor,
          ),
        ),
        title: Wrap(
          children: [
            Text(
                "${getTransactiontype(transaction.transactionType.toString())}",
                style: TextStyle(fontSize: 15)),
            Text("  -  ***", style: TextStyle(fontSize: 15)),
            Text("${transaction.receiverPhone}".substring(4),
                style: TextStyle(fontSize: 15)),
          ],
        ),
        subtitle: Text(
            "${DateFormat('d MMMM , y  hh:mm a').format(transaction.transactionTime!)}"),
        trailing: Text(
          "\$${transaction.amount}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

}
