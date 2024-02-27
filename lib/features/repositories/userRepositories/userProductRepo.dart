import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/const/fbConst.dart';
import 'package:delivery_app/models/productModel.dart';

class UserProductRepository {
  
  final FirebaseFirestore firestore;

  UserProductRepository({required this.firestore});

  ///get product by category as stream data
  Stream<List<ProductModel>> getProductByCategory(String category) {
    return firestore
        .collection(FirebaseConstant.prooductCollection)
        .where('category', isEqualTo: category)
        .snapshots()
        .map((event) => event.docs
            // ignore: unnecessary_cast
            .map((e) => ProductModel.fromJson(e.data() as Map<String, dynamic>))
            .toList());
  }

  //get product detail
  Stream<ProductModel> getProductById(String id) {
    return firestore
        .collection(FirebaseConstant.prooductCollection)
        .doc(id)
        .snapshots()
        .map(
          (event) =>
              ProductModel.fromJson(event.data() as Map<String, dynamic>),
        );
  }

  //search products
  Future<List<ProductModel>> getAllProducts()async{
    return firestore.collection(FirebaseConstant.prooductCollection).get().then((value){
      // ignore: unnecessary_cast
      return value.docs.map((e) => ProductModel.fromJson(e.data() as Map<String,dynamic>)).toList();
    });
  }


  ///set product to favoirutes
  setProductToFav({required String productId})async{

    var userCollection = firestore.collection(FirebaseConstant.userCollection);
    DocumentSnapshot userData = await userCollection.doc(CurrentUser.uid).get();
    if(userData["favProducts"].contains(productId)){
      userCollection.doc(CurrentUser.uid).update({
        'favProducts':FieldValue.arrayRemove([productId])
      });
    }else{
      userCollection.doc(CurrentUser.uid).update({
        'favProducts':FieldValue.arrayUnion([productId])
      });
    }
      
  }   
}
