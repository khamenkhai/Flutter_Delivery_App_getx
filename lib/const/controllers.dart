import 'package:delivery_app/features/controllers/auth_controller/auth_controller.dart';
import 'package:delivery_app/features/controllers/adminControllers/categoryController.dart';
import 'package:delivery_app/features/controllers/adminControllers/deliveryController.dart';
import 'package:delivery_app/features/controllers/adminControllers/driverController.dart';
import 'package:delivery_app/features/controllers/adminControllers/orderController.dart';
import 'package:delivery_app/features/controllers/adminControllers/productController.dart';
import 'package:delivery_app/features/controllers/driverControllers/driverDeliveryController.dart';
import 'package:delivery_app/features/controllers/userControllers/cartController.dart';
import 'package:delivery_app/features/controllers/userControllers/userController.dart';
import 'package:delivery_app/features/controllers/userControllers/userOrderController.dart';
import 'package:delivery_app/features/controllers/userControllers/userProductController.dart';

//admin controllers
final CategoryController categoryController = CategoryController.instance;
final ProductController productController = ProductController.instance;
final OrderController orderController = OrderController.instance;
final DeliveryController deliveryController = DeliveryController.instance;
final DriverController driverController = DriverController.instance;

//user controllers
final UserProductController userProductController = UserProductController.instance;
final UserOrderController userOrderController = UserOrderController.instance;
final UserCartController cartController = UserCartController.instance;

//driver
final DriverDeliveryController driverDeliveryController = DriverDeliveryController.instance;

//auth
final AuthController authController = AuthController.instance;
final UserController userController = UserController.instance;