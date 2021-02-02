
import 'package:get/get.dart';
import 'package:user_app/GetxControllers/authController.dart';
import 'package:user_app/GetxControllers/loginController.dart';

class InstanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<LoginController>(() => LoginController());
  }


}