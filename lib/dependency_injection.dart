import 'package:delivery_app/const/fbConst.dart';
import 'package:delivery_app/features/controllers/adminControllers/categoryController.dart';
import 'package:delivery_app/features/controllers/adminControllers/productController.dart';
import 'package:delivery_app/features/controllers/userControllers/userController.dart';
import 'package:delivery_app/features/repositories/adminRepositories/categoryRepo.dart';
import 'package:delivery_app/features/repositories/adminRepositories/productRepositoryes.dart';
import 'package:delivery_app/features/controllers/userControllers/cartController.dart';
import 'package:delivery_app/features/controllers/userControllers/userOrderController.dart';
import 'package:delivery_app/features/controllers/userControllers/userProductController.dart';
import 'package:delivery_app/features/repositories/userRepositories/userOrderRepository.dart';
import 'package:delivery_app/features/repositories/userRepositories/userProductRepo.dart';
import 'package:delivery_app/features/repositories/userRepositories/userRepository.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupLocatorForUser() {
  locator.registerSingleton<CategoryRepository>(
    CategoryRepository(firestore: FirebaseConstant.firestore),
  );

  locator.registerSingleton<CategoryController>(
    CategoryController(categoryRepository: locator<CategoryRepository>()),
  );

  // locator.registerSingleton<ProductController>(
  //   ProductController(productRepository: locator<ProductRepository>()),
  // );

  locator.registerSingleton<UserProductController>(
    UserProductController(
        userProductRepository: locator<UserProductRepository>()),
  );

  locator.registerSingleton<UserOrderController>(
    UserOrderController(userOrderRepository: locator<UserOrderRepository>()),
  );

  locator.registerSingleton<UserCartController>(
    UserCartController(),
  );

  locator.registerSingleton<UserController>(
    UserController(userRepository: UserRepository()),
  );

  locator.registerSingleton<UserController>(
    UserController(userRepository: UserRepository()),
  );

  // locator.registerSingleton<ProductRepository>(
  //   ProductRepository(firestore: FirebaseConstant.firestore),
  // );

  locator.registerSingleton<UserOrderRepository>(
    UserOrderRepository(firestore: FirebaseConstant.firestore),
  );
  locator.registerSingleton<UserProductRepository>(
    UserProductRepository(firestore: FirebaseConstant.firestore),
  );
}
