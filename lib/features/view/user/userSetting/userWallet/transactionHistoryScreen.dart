import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/const/controllers.dart';
import 'package:delivery_app/models/moneyTransactionModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  @override
  void initState() {
    userController.getAllTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
      ),
      body: Obx(
        () {
          return ListView.separated(
            padding: EdgeInsets.only(left: 15, right: 15),
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
        },
      ),
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
