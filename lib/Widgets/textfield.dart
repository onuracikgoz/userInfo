import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/const.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final bool isPassword ;


InputField({this.controller,this.hintText,this.icon,this.onChanged,this.isPassword=false});

  @override
  Widget build(BuildContext context) {
    
      Size size = Get.size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: primaryBlueColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
        
        obscureText: isPassword,
        style: TextStyle(color: Colors.white),
        controller: controller ,
        
        onChanged: onChanged,
        cursorColor: primaryTextColor,
        
        decoration: InputDecoration(

          icon: Icon(
            icon,
            color: primaryTextColor,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white),
          border: InputBorder.none,

        ),
      ), 
    );
  }
}