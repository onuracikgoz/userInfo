
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:user_app/GetxControllers/authController.dart';
import 'package:user_app/GetxControllers/loginController.dart';
import 'package:user_app/Screens/userList.dart';
import 'package:user_app/Widgets/roundedButton.dart';
import 'package:user_app/Widgets/textfield.dart';
import 'package:user_app/const.dart';

class LoginPage extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  final AuthController authController = Get.put((AuthController()));

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController retryPassword = TextEditingController();

  LoginPage(){

      loginController.isLogin.value=false;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                color: Colors.white,
              ),
              Center(
                  child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Image.asset("assets/images/internativeLogo.png"),
                  SizedBox(
                    height: 50,
                  ),
                  InputField(
                    hintText: "E-mail",
                    icon: Icons.email,
                    controller: email,
                  ),
                  InputField(
                    hintText: "Şifre",
                    icon: Icons.vpn_key,
                    controller: password,
                    isPassword: true,
                  ),
                  Obx(
                    () => loginController.loginBool
                        ? InputField(
                            hintText: "Şifre Tekrar",
                            icon: Icons.vpn_key,
                            controller: retryPassword,
                            isPassword: true)
                        : Container(),
                  ),
                  Obx(() => loginController.loginBool
                      ? RoundedButton(
                          text: "Üye ol",
                          color: Colors.blueAccent,
                          press: createUser,
                          textColor: primaryTextColor,
                        )
                      : RoundedButton(
                          text: "Giriş",
                          color: Colors.blueAccent,
                          press: login,
                          textColor: primaryTextColor ,
                        )),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap:  loginController.changeLogin ,
                      child: Obx(() => loginController.loginBool
                          ? RichText(
                              text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: "Zaten hesabın var mı?",
                                  style: TextStyle(
                                      color: primaryBlueColor, fontSize: 20),
                                ),
                                TextSpan(
                                  text: " Giriş yap",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryBlueColor,
                                      fontSize: 20),
                                )
                              ],
                            ))
                          : RichText(
                              text: TextSpan(
                                text: 'Hesabın yok mu? ',
                                style: TextStyle(
                                  color: primaryBlueColor,
                                  fontSize: 20,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Üye ol',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryBlueColor,
                                        fontSize: 20,
                                      )),
                                ],
                              ),
                            )))
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  void createUser() {
    if (password.text.isEmpty ||
        retryPassword.text.isEmpty ||
        email.text.isEmpty)
      Get.snackbar(
          "Hesap oluşturulurken hata", "Lütfen boş alanları doldurunuz");
    else {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email.text);
      if (emailValid) {
        if (password.text == retryPassword.text) {
          authController.createUser(email.text, password.text);
        } else {
          Get.snackbar("Hesap oluşturulurken hata",
              "Şifreler eşleşmiyor lütfen tekrar giriniz");
        }
      } else {
        Get.snackbar("Hesap oluşturulurken hata",
            "e-mail adresinizi doğru formatta giriniz");
      }
    }
  }

  void login (){
     if (password.text.isEmpty ||
        email.text.isEmpty)
      Get.snackbar(
          "Hesap oluşturulurken hata", "Lütfen boş alanları doldurunuz");
    else {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email.text);
      if (emailValid) {
        authController.login(email.text, password.text);
      } else {
        Get.snackbar("Hesap oluşturulurken hata",
            "e-mail adresinizi doğru formatta giriniz");
      }
    }

    Get.off(UserList(), transition: Transition.zoom);
  }

   


  }

