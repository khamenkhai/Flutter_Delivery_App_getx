import 'package:delivery_app/models/cartModel.dart';

class OrderModel {
  final String? orderId;
  final String? userName;
  final String? userId;
  final int? userPhoneNumber;
  final DateTime? time;
  final String? orderStatus;
  final double? totalAmount;
  final String? address;
  final List<CartModel> products;
  final bool? paid;

  // Constructor
  OrderModel({
     this.orderId,
     this.userName,
     this.userPhoneNumber,
     this.userId,
     this.time,
     this.orderStatus,
     this.totalAmount,
     this.address,
     required this.products,
    this.paid,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'],
      userName: json['userName'],
      userId: json['userId'],
      userPhoneNumber: json["userPhoneNumber"],
      time: DateTime.fromMillisecondsSinceEpoch(json['time']),
      orderStatus: json['orderStatus'],
      totalAmount: json['totalAmount'].toDouble(),
      address: json['address'],
      paid: json['paid'],
      products: (json['products'] as List)
          .map((product) => CartModel.fromJson(product))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'userName': userName,
      'userId': userId,
      'userPhoneNumber': userPhoneNumber,
      'time': time?.millisecondsSinceEpoch,
      'orderStatus': orderStatus,
      'totalAmount': totalAmount,
      'products': products.map((product) => product.toJson()).toList(),
      'address': address,
      'paid': paid,
    };
  }
}
