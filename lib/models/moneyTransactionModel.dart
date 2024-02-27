class MoneyTransactionModel {
  String? id;
  num? amount;
  String? transactionType;
  String? note;
  DateTime? transactionTime;
  String? senderName;
  String? senderPhone;
  String? senderId;
  String? receiverName;
  String? receiverPhone;
  String? receiverId;
  String? orderId;


  MoneyTransactionModel({
    this.id,
    this.amount,
    this.transactionType,
    this.note,
    this.transactionTime,
    this.senderName,
    this.senderPhone,
    this.senderId,
    this.receiverName,
    this.receiverPhone,
    this.receiverId,
    this.orderId,
  });

  factory MoneyTransactionModel.fromMap(Map<String, dynamic> map) {
    return MoneyTransactionModel(
      id: map['id'],
      amount: map['amount'],
      transactionType: map['transactionType'],
      note: map['note'],
      transactionTime: map['transactionTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['transactionTime'])
          : null,
      senderName: map['senderName'],
      senderPhone: map['senderPhone'],
      senderId: map['senderId'],
      receiverName: map['receiverName'],
      receiverPhone: map['receiverPhone'],
      receiverId: map['receiverId'],
      orderId: map['orderId'],
    );
  }


   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'transactionType': transactionType,
      'note': note,
      'transactionTime': transactionTime?.millisecondsSinceEpoch,
      'senderName': senderName,
      'senderPhone': senderPhone,
      'senderId': senderId,
      'receiverName': receiverName,
      'receiverPhone': receiverPhone,
      'receiverId': receiverId,
      'orderId': orderId,
    };
  }

  MoneyTransactionModel copyWith({
    String? id,
    num? amount,
    String? transactionType,
    String? note,
    DateTime? transactionTime,
    String? senderName,
    String? senderPhone,
    String? senderId,
    String? receiverName,
    String? receiverPhone,
    String? receiverId,
    String? orderId,
  }) {
    return MoneyTransactionModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      transactionType: transactionType ?? this.transactionType,
      note: note ?? this.note,
      transactionTime: transactionTime ?? this.transactionTime,
      senderName: senderName ?? this.senderName,
      senderPhone: senderPhone ?? this.senderPhone,
      senderId: senderId ?? this.senderId,
      receiverName: receiverName ?? this.receiverName,
      receiverPhone: receiverPhone ?? this.receiverPhone,
      receiverId: receiverId ?? this.receiverId,
      orderId: orderId ?? this.orderId,
    );
  }

}
