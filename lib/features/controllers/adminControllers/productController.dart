import 'dart:typed_data';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/features/repositories/adminRepositories/productRepositoryes.dart';
import 'package:delivery_app/features/repositories/adminRepositories/storageRepository.dart';
import 'package:delivery_app/models/productModel.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductRepository productRepository;

  ProductController({required this.productRepository});

  static ProductController instance = Get.find();

  final RxList<ProductModel> products = RxList<ProductModel>();

  var loading = false.obs;

  @override
  void onInit() {
    productRepository.getAllProducts().listen((event) {
      products.assignAll(event);
    });
    super.onInit();
  }

  //create new product
  Future<bool> createNewProduct({
    required String name,
    required Uint8List photo,
    required String category,
    required double price,
    required String color,
    required int quantity,
    required String description,
  }) async {
    loading.value = true;
    String productImage = await storeFileInFirebase(
      fileName: name,
      imageData: photo,
      path: "DAproducts",
    );
    var productId = generateRandomId();
    ProductModel product = ProductModel(
      productId: productId,
      name: name,
      category: category,
      productImage: productImage,
      color: color,
      currentPrice: price,
      discount: 0,
      quantity: quantity,
      rawPrice: 0,
      description: description,
    );
    bool value = await productRepository.createNewProduct(product);
    loading.value = false;
    return value;
  }

  //edit product
  Future<bool> editProduct({required
    ProductModel product,
    Uint8List? file
  }) async {
    loading.value = true;
    String? productImage;
   if(file!=null){
     productImage = await storeFileInFirebase(
      fileName: product.name.toString(),
      imageData: file,
      path: "DAproducts",
    );
   }

    bool value = await productRepository.editProduct(product.copyWith(productImage: productImage));
    loading.value = false;
    return value;
  }

  //testing
  testin() async {
    loading.value = true;
    await Future.delayed(Duration(seconds: 3));
    loading.value = false;
  }
}
