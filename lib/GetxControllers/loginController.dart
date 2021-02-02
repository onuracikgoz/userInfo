import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLogin = false.obs;

  get loginBool => isLogin.value;

  set setloginBool(value) => isLogin.value = value;

  void changeLogin() {
    isLogin.value = isLogin.value ? false : true;
  }
}
