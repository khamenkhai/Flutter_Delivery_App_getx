class DeliveryModel {
  final String? deliveryId;
  final String? orderId;
  final String? deliveryManId;
  final String? deliveryManName;
  final String? customerName;
  final String? customerPhone;
  final String? status;
  final String? address;
  final DateTime? orderTime;
  DateTime? deliveredTime;
  final num? totalPrice;
  final String? customerSignature;

  DeliveryModel({
    this.deliveryId,
    this.orderId,
    this.deliveryManId,
    this.deliveryManName,
    this.status,
    this.address,
    this.customerName,
    this.customerPhone,
    this.orderTime,
    this.deliveredTime,
   this.totalPrice,
   this.customerSignature
  });

  factory DeliveryModel.fromJson(Map<String, dynamic> json) {
    return DeliveryModel(
      deliveryId: json["deliveryId"],
      orderId: json["orderId"],
      deliveryManId: json["deliveryManId"],
      deliveryManName: json["deliveryManName"] ?? "",
      customerName: json["customerName"],
      customerPhone: json["customerPhone"],
      status:json["status"],
      address:json["address"],
      totalPrice:json["totalPrice"],
      customerSignature:json["customerSignature"],
      orderTime:  DateTime.fromMillisecondsSinceEpoch(json['orderTime']),
      deliveredTime:DateTime.fromMillisecondsSinceEpoch(json['deliveredTime'] ?? 0),

    );
  }

  toJson(){
    return {
      "deliveryId":this.deliveryId,
      "orderId":this.orderId,
      "deliveryManId":this.deliveryManId,
      "deliveryManName":this.deliveryManName,
      "status":this.status,
      "customerSignature":this.customerSignature,
      "customerName":this.customerName,
      "customerPhone":this.customerPhone,
      "address":this.address,
      "totalPrice":this.totalPrice,
      "orderTime":this.orderTime?.millisecondsSinceEpoch,
      "deliveredTime":this.deliveredTime?.millisecondsSinceEpoch,
    };
  }
}
