import 'package:flutter/material.dart';
import 'package:get/get.dart';



class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
 

 RoundedButton({this.text="Button", this.press,this.color,this.textColor});

  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
          color: color,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 20),
          ),
        ),
      ),
    );
  }
}