import 'package:delivery_app/models/moneyTransactionModel.dart';

class UserModel {
  final String userId;
  final String name;
  final String email;
  final String phoneNumber;
  final String? accountPassword;
  final num? accountBalance;
  final String? address;
  final String? role;
  final String? profilePhoto;
  final List<String>? favProducts;
  final List<MoneyTransactionModel>? moneyTranscationHistory;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    this.accountPassword,
    required this.phoneNumber,
    this.accountBalance,
    this.address,
    this.role,
    this.favProducts,
    this.moneyTranscationHistory,
    required this.profilePhoto,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
  return UserModel(
    userId: json['userId'],
    name: json['name'] ?? '',
    email: json['email'] ?? '',
    accountPassword: json['accountPassword'] ?? '',
    phoneNumber: json['phoneNumber'] ?? '',
    accountBalance: json['accountBalance'] ?? 0, 
    address: json['address'] ?? '',
    role: json['role'] ?? '',
    favProducts: List<String>.from(json['favProducts'] ?? []),
    moneyTranscationHistory: List<MoneyTransactionModel>.from(
        (json['moneyTranscationHistory'] ?? []).map(
          (transaction) => MoneyTransactionModel.fromMap(transaction),
        ),
      ),
    profilePhoto: json['profilePhoto'] ?? '',
  );
}


  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'accountPassword': accountPassword,
      'phoneNumber': phoneNumber,
      'address': address,
      'accountBalance': accountBalance,
      'role': role,
      'favProducts': favProducts,
      'moneyTranscationHistory': moneyTranscationHistory,
      'profilePhoto': profilePhoto
    };
  }

  UserModel copyWith({
    String? userId,
    String? name,
    String? userRole,
    String? phoneNumber,
    String? address,
    String? email,
    String? accountPassword,
    double? accountBalance,
    String? role,
    List<String>? favProducts,
    List<MoneyTransactionModel>? moneyTranscationHistory,
    String? profilePhoto,
  }) {
    return UserModel(
      accountBalance: accountBalance ?? this.accountBalance,
      email: email ?? this.email,
      accountPassword: accountPassword ?? this.accountPassword,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      role: role ?? this.role,
      favProducts: favProducts ?? this.favProducts,
      moneyTranscationHistory:
          moneyTranscationHistory ?? this.moneyTranscationHistory,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }
}
