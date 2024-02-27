import 'package:flutter/material.dart';

abstract class Constant {
  static const String DATABASE_NAME = "taskdb.db";
  static const int DATABASE_VERSION = 1;
  static const String TASK_TABLE_NAME = "task";
  static const bool ENABLE_LOGS = true;

  static const String NOTIFICATION_PAYLOAD_DEFAULT = "notification";

  static const String LANGUAGE_CODE_MY = "my";
  static const String LANGUAGE_CODE_EN = "en";
}

abstract class ThemeConstant {
  static final Color primaryColor = Colors.grey.shade900;
  static final Color secondaryTextColor = Colors.grey.shade700;
  //static final Color backgroundColor= Colors.grey.shade300;
  static final Color backgroundColor = Colors.white;
  static final Color cardColor = Colors.grey.shade100;
  //static final Color cardColor = Colors.grey.shade200;
}

class OrderStatus {
  //order status
  static final String pending = "Pending";
  static final String assignedOrder = "Assigned";
  static final String completed = "Delivered";
  static final String history = "History";
}

abstract class DeliveryStatus {
  
  static final String pending = "Pending";
  static final String active = "Active";
  static final String complete = "Completed";
  static final String history = "History";

}

class TransactionType{
  static  final String send = "Send";
   static final String receive = "Receive";
}


getTransactiontype(String transaction){
  return transaction == TransactionType.send ? "Transfer To" : transaction == TransactionType.receive ? "Transfer From" : "";
}

//in order list is the stats is to assign mark the status as order pending
Color getColorByStatus(String status) {
if (status == DeliveryStatus.pending) {
    return Colors.amber.shade700;
  } else if (status == DeliveryStatus.active) {
    return Colors.blue;
  } else if (status == DeliveryStatus.complete) {
    return Colors.lightGreen;
  } else {
    return Colors.teal;
  }
}

Color getColorByOrderStatus(String status) {
if (status == OrderStatus.pending) {
    return Colors.amber.shade700;
  } else if (status == OrderStatus.assignedOrder) {
    return Colors.blue;
  } else if (status == OrderStatus.completed) {
    return Colors.green;
  } else {
    return Colors.teal;
  }
}

