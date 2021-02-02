import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'package:user_app/Model/user.dart';

class DocumentController extends GetxController {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  createNewUserDocument(String userID) async {
    try {
      var rng = new Random();
      var randomInt = rng.nextInt(2);

      await _firebaseFirestore.collection("users").doc(userID).set({
        'id': userID,
        'userName': faker.internet.userName(),
        'firstName': faker.person.name(),
        'description': "This area for description",
        'likeCount': 0,
        'createdTime': DateTime.now(),
        'imgUrl': "avatar" + randomInt.toString() + ".png"
      });
    } on Exception catch (e) {
      Get.snackbar("Kullanıcı bilgileri oluşturulurken hata meydana geldi",
          e.toString());
    }
  }

  Future<List<User>> getAllUser() async {
     List<User> userList = <User>[].obs;
    await _firebaseFirestore.collection("users").get().then(
        (QuerySnapshot querySnapshot) => querySnapshot.docs.forEach((element) {
              userList.add(User.fromMap(element));
            }));
    return userList;
  }

   Future<User> getUserInfo(String userID) async {
     
    var result = await _firebaseFirestore.collection("users").doc(userID).get();
    
return User.fromMap(result);
      
  }
}
