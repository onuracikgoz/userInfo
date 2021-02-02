import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:user_app/GetxControllers/authController.dart';
import 'package:user_app/GetxControllers/documentController.dart';
import 'package:user_app/Model/user.dart';
import 'package:user_app/Screens/userDetails.dart';
import 'package:user_app/const.dart';

class UserList extends StatelessWidget {
  final DocumentController documentController = Get.put((DocumentController()));
  final AuthController authController = Get.put((AuthController()));
  List<User> _user = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Color(0xFFF5F6F9),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 20),
                Container(
                  color: Color(0xFFF5F6F9),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: FutureBuilder<List<User>>(
                    future: documentController.getAllUser(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<User>> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.done:
                          _user = snapshot.data;
                          return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 300,
                                      childAspectRatio: 1,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                              itemCount: _user.length,
                              itemBuilder: (BuildContext context, index) {
                                return InkWell(
                                  onTap: () {
                                    
                                    Get.to(UserDetails(_user[index].id));},
                                  child: Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    elevation: 5.0,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          
                                          Expanded(
                                            child: Image.asset(
                                                "assets/images/${_user[index].imgUrl}"),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              _user[index].userName,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ),
                                         
                                         
                                        ]),
                                  ),
                                );
                              });

                        case ConnectionState.none:
                          return (Text(
                              "Ekran yüklenirken bir hata oluştu bir daha deneyiniz."));
                        case ConnectionState.waiting:
                          return Container(
                              child: Center(
                                  child: Text(
                            "Butikler yükleniyor lütfen bekleyiniz...",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          )));

                        case ConnectionState.active:
                          return Container();
                        default:
                          return Container();
                      }
                    },
                  ),
                ),
              ],
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
      actions: [
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: authController.signOut,
              child: Icon(
                Icons.logout,
                size: 26.0,
                color: Colors.black,
              ),
            ))
      ],
    );
  }
}
