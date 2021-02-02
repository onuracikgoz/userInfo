import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:user_app/GetxControllers/documentController.dart';
import 'package:user_app/Model/user.dart';
import 'package:user_app/const.dart';

class UserDetails extends StatelessWidget {
  DocumentController _documentController = Get.find<DocumentController>();

  String userID;

  UserDetails(this.userID);
  User _user = User();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: FutureBuilder<User>(
              future: _documentController.getUserInfo(userID),
              builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    _user = snapshot.data;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10.0),
                        Container(
                          width: Get.size.width * 0.8,
                          height: Get.size.height * 0.3,
                          child: Material(
                            elevation: 30.0,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ClipOval(
                                child: ClipRRect(
                                  child: Image.asset(
                                    "assets/images/${_user.imgUrl}",
                                    fit: BoxFit.contain,
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                            decoration: BoxDecoration(
                              color: primaryBlueColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0),
                                  topRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            width: Get.size.width * 0.8,
                            height: Get.size.height * 0.5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    _user.userName,
                                    style: textStyleForDetail.copyWith(
                                        fontFamily: "Bebas"),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(_user.firstname,
                                      style: textStyleForDetail),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    _user.description,
                                    style: textStyleForDetail.copyWith(
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    );

                  case ConnectionState.none:
                    return (Text(
                        "Ekran yüklenirken bir hata oluştu bir daha deneyiniz."));
                  case ConnectionState.waiting:
                    return Container(
                        child: Center(
                            child: Text(
                      "Butikler yükleniyor lütfen bekleyiniz...",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    )));

                  case ConnectionState.active:
                    return Container();
                  default:
                    return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
        centerTitle: true,
        title: Text("Çalışanlar Listesi",
            style: TextStyle(
              color: Colors.black,
            )),
        elevation: 3.0,
        backgroundColor: primaryTextColor,
        leading: Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: Get.back,
              child: Icon(
                Icons.arrow_back_ios_outlined,
                size: 26.0,
                color: Colors.black,
              ),
            )));
  }
}
