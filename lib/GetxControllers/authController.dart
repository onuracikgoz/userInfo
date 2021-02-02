import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:user_app/GetxControllers/documentController.dart';
import 'package:user_app/Screens/loginPage.dart';
import 'package:user_app/Screens/userList.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  final DocumentController documentController = Get.put((DocumentController()));

  Rx<User> _firebaseUser = Rx<User>();

  get user => _firebaseUser.value;

  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  void createUser(String email, String password) async {
    try {
      var _result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      documentController.createNewUserDocument(_result.user.uid);
      

      Get.offAll(LoginPage());
    } catch (e) {
      Get.snackbar("Hesap oluştururken bir hata meydana geldi", e.toString());
    }
  }

  void login(String email, String password) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => Get.offAll(UserList()))
        .catchError((onError) => Get.snackbar(
            "Giriş sırasında bir hata meydana geldi", onError.message));
  }

  void signOut() async {
    await _auth.signOut().then((value) => Get.offAll(LoginPage()));
  }
}
