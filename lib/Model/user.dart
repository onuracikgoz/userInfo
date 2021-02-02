import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String userName;
  String firstname;
  String description;
  int likeCount;
  DateTime createdTime;
  String imgUrl;

  User({this.createdTime, this.description, this.firstname, this.id, this.imgUrl,
      this.likeCount, this.userName});

  User.fromMap(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot["id"];
    userName = documentSnapshot["userName"];
    firstname = documentSnapshot["firstName"];
    description = documentSnapshot["description"];
    likeCount = documentSnapshot["likeCount"];
    createdTime = documentSnapshot["createdTime"].toDate();
    imgUrl = documentSnapshot["imgUrl"];
  }
}
