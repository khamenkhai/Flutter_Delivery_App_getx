class ProductModel {
  final String? productId;
  final String? name;
  final String? description;
  final String? category;
  final String? productImage;
  final double? discount;
  final double? currentPrice;
  final double? rawPrice;
  final int? quantity;
  final String? color;


  ProductModel({
    this.productId,
    this.name,
    this.description,
    this.category,
    this.productImage,
    this.discount,
    this.currentPrice,
    this.rawPrice,
    this.quantity,
    this.color,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        productId: json['productId'],
        description:json['description'],
        name: json['name'],
        category: json['category'],
        productImage: json['productImage'],
        discount: json['discount'].toDouble(),
        currentPrice: json['currentPrice'].toDouble(),
        rawPrice: json['rawPrice'].toDouble(),
        quantity: json['quantity'],
        color: json['color']);
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'description':description,
      'name': name,
      'category': category,
      'productImage': productImage,
      'discount': discount,
      'currentPrice': currentPrice,
      'rawPrice': rawPrice,
      'quantity': quantity,
      'color': color
    };
  }


   double getCurrentPrice() {
    if (rawPrice != null && discount != null) {
      return rawPrice! - (rawPrice! * (discount! / 100));
    } else {
      return currentPrice ?? 0.0;
    }
  }


    ProductModel copyWith({
    String? productId,
    String? name,
    String? description,
    String? category,
    String? productImage,
    double? discount,
    double? currentPrice,
    double? rawPrice,
    int? quantity,
    String? color,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      productImage: productImage ?? this.productImage,
      discount: discount ?? this.discount,
      currentPrice: currentPrice ?? this.currentPrice,
      rawPrice: rawPrice ?? this.rawPrice,
      quantity: quantity ?? this.quantity,
      color: color ?? this.color,
    );
  }
}
