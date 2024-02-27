// ignore_for_file: unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/const/fbConst.dart';
import 'package:delivery_app/models/productModel.dart';

class ProductRepository {
  final FirebaseFirestore firestore;

  ProductRepository({required this.firestore});


  //createe new product
  Future<bool> createNewProduct(ProductModel product) async {
    try{
      await firestore
        .collection(FirebaseConstant.prooductCollection)
        .doc(product.productId)
        .set(product.toJson());
      return true;
    }on FirebaseException catch(e){
      if(Constant.ENABLE_LOGS){
        print("Error at crete new product : ${e.message}\n ${e}");
      }
      return false;
    }
  }

  //edit product
  Future<bool> editProduct(ProductModel product) async {
    try{
      var productCollection = firestore.collection(FirebaseConstant.prooductCollection);

      Map<String, dynamic> productInformation = Map();

         
    if (product.name != "" && product.name != null) productInformation['name'] = product.name;
    if (product.category != "" && product.category != null) productInformation['category'] = product.category;
    if (product.currentPrice != "" && product.currentPrice != null) productInformation['currentPrice'] = product.currentPrice;
    if (product.discount != "" && product.discount != null) productInformation['discount'] = product.discount;
    if (product.productImage != "" && product.productImage != null) productInformation['productImage'] = product.productImage;

      await productCollection.doc(product.productId!).update(productInformation);
      return true;
    }on FirebaseException catch(e){
      if(Constant.ENABLE_LOGS){
        print("Error at crete new product : ${e.message}\n ${e}");
      }
      return false;
    }
  }


  ///print test
  Stream<List<ProductModel>> getAllProducts(){
    return firestore.collection(FirebaseConstant.prooductCollection).snapshots()
    .map((event) => event.docs.map((e) => ProductModel.fromJson(e.data() as Map<String,dynamic>)).toList());
  }
}
