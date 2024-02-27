class CartModel {
  final String id;
  int quantity;

  CartModel({required this.id, required this.quantity});

  factory CartModel.fromJson(Map<String, dynamic> map) {
    return CartModel(
      id: map["id"],
      quantity: map["quantity"],
    );
  }

  toJson(){
    return {
      "id":id,
      "quantity":quantity
    };
  }
}
