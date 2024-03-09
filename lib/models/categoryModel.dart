class CategoryModel {
  final String? categoryId;
  final String? categoryName;
  final String? categoryImage;
  final String? colorCode;

  CategoryModel({
     this.categoryId,
     this.categoryName,
     this.categoryImage,
     this.colorCode,
  });

  
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      categoryImage: json['categoryImage'],
      colorCode: json['colorCode'],
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'categoryImage': categoryImage,
      'colorCode': colorCode,
    };
  }
}
