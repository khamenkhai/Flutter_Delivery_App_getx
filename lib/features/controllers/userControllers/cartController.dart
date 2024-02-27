import 'package:delivery_app/features/controllers/adminControllers/productController.dart';
import 'package:delivery_app/models/cartModel.dart';
import 'package:delivery_app/models/productModel.dart';
import 'package:get/get.dart';

class UserCartController extends GetxController {

  static UserCartController instance = Get.find();

  ProductController _productController = Get.find();

  RxList<CartModel> _myCart = <CartModel>[].obs;

  List<CartModel> get myCart => _myCart;

  double get totalAmount => _totalAmount();

  

  var loading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  addToCart(CartModel cartProduct,int quantity){
    if(checkIsProductExisted(cartProduct.id)){
      _myCart.forEach((element) { 
        if(element.id == cartProduct.id){
          element.quantity += quantity;
        }
      });
    }else{
      _myCart.add(cartProduct);
    }
  }


  removeFromCart(CartModel cartProduct){
    if(cartProduct.quantity ==1){
      _myCart.removeWhere((element) => element.id == cartProduct.id);
    }else if(cartProduct.quantity > 1){
      _myCart.forEach((element) { 
        if(element.id == cartProduct.id){
          element.quantity -=1;
        }
      });
    }
  }

  double _totalAmount(){

    double totalAmount = 0;

    _myCart.forEach((cartItem) {
      // ignore: invalid_use_of_protected_member
      ProductModel cartProduct = _productController.products.value.where((element) => element.productId == cartItem.id).first;
      totalAmount += cartItem.quantity * cartProduct.currentPrice!;
    });
    return totalAmount;
  }


  bool checkIsProductExisted(String productId){
    return _myCart.any((p) => p.id == productId);
  }

  clearCart(){
    _myCart.clear();
  }

}
