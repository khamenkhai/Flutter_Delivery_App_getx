import 'dart:typed_data';
import 'package:delivery_app/const/utils.dart';
import 'package:delivery_app/features/repositories/adminRepositories/categoryRepo.dart';
import 'package:delivery_app/features/repositories/storageRepository/storageRepository.dart';
import 'package:delivery_app/models/categoryModel.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {

  final CategoryRepository categoryRepository;

  CategoryController({required this.categoryRepository});

  static CategoryController instance = Get.find();
    
  final RxList<CategoryModel> categories = RxList<CategoryModel>();

  var loading = false.obs;

   @override
  void onInit() {
    categoryRepository.getAllCatetories().listen((event) { 
      categories.assignAll(event);
    });
    super.onInit();
  }
  //create new category
  Future<bool> createNewCategory(
      {required String categoryName,
      required Uint8List photo,
      required String colorcode}) async {
    loading.value = true;
    String categoryImage = await FirebaseStorageRepository.storeFileInFirebase(
      fileName: categoryName,
      imageData: photo,
      path: "DAcategories",
    );
    var categoryId = generateRandomId();
    CategoryModel category = CategoryModel(
      categoryId: categoryId,
      categoryName: categoryName,
      categoryImage: categoryImage,
      colorCode: colorcode,
    );
    bool value = await categoryRepository.createNewCategory(category);
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
