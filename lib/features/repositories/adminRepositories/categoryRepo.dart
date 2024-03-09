// ignore_for_file: unnecessary_cast
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/models/categoryModel.dart';
import 'package:delivery_app/const/const.dart';
import 'package:delivery_app/const/fbConst.dart';

class CategoryRepository {
  final FirebaseFirestore firestore;

  CategoryRepository({required this.firestore});


  //createe new category
  Future<bool> createNewCategory(CategoryModel category) async {
    try{
      await firestore
        .collection(FirebaseConstant.categoryCollection)
        .doc(category.categoryId)
        .set(category.toJson());
      return true;
    }on FirebaseException catch(e){
      if(Constant.ENABLE_LOGS){
        print("Error at crete new category : ${e.message}\n ${e}");
      }
      return false;
    }
  }


  ///print test
  Stream<List<CategoryModel>> getAllCatetories(){
    return firestore.collection(FirebaseConstant.categoryCollection).snapshots()
    .map((event) => event.docs.map((e) => CategoryModel.fromJson(e.data() as Map<String,dynamic>)).toList());
  }
}
