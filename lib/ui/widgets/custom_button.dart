import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  VoidCallback? onclick;
  String title;
  Color borderColor;
  Color background;
  Color? textColor;
  double? textSize;
  CustomButton({Key? key, this.onclick,required this.title,required this.background,required this.borderColor,this.textColor,this.textSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onclick,
      style: ElevatedButton.styleFrom(
        primary: background,
        shape: RoundedRectangleBorder(
          side: BorderSide(color:borderColor ,width:2),
          borderRadius: BorderRadius.circular(20),


        ),
      ),
      child: Text(title,style: TextStyle(color: textColor,fontSize: textSize??14),),
    );
  }
}
