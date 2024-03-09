import 'package:delivery_app/models/productModel.dart';
import 'package:delivery_app/features/repositories/userRepositories/userProductRepo.dart';
import 'package:get/get.dart';

class UserProductController extends GetxController {
  final UserProductRepository userProductRepository;

  UserProductController({required this.userProductRepository});

  static UserProductController instance = Get.find();

  final RxList<ProductModel> productsByCategory = RxList<ProductModel>();

  final Rx<ProductModel> _product = ProductModel().obs;

  ProductModel get product => _product.value;

  RxList<ProductModel> _searchedProducts = RxList<ProductModel>();

  List<ProductModel> get getSearchProducts => _searchedProducts;

  var loading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  //get products list by category name
  getProductsbyCategory(String category) async {
    loading.value = true;
    await Future.delayed(Duration(milliseconds: 300));
    userProductRepository.getProductByCategory(category).listen((event) {
      productsByCategory.assignAll(event);
    });
    loading.value = false;
  }

  //get product detail by id
  Stream<ProductModel> getProductById(String productId) {
    return userProductRepository.getProductById(productId);
  }

  //search product
  searchProducts(String query) async {

    loading.value = true;
    List<ProductModel> results = await userProductRepository.getAllProducts();
    _searchedProducts.clear();
    loading.value = false;
    _searchedProducts.addAll(results.where((element) {
      final result = "${element.name}".toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList());
  }

  ///add product to fav
  addProductToFav({required String productId}) {
    userProductRepository.setProductToFav(productId: productId);
  }
}
