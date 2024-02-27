import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  const MyText({super.key,required this.text,this.fontSize = 15,this.fontWeight = FontWeight.normal,this.color,this.textAlign = TextAlign.start});
  final String text;
  final double fontSize;
  final  fontWeight;
  final Color? color;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(text,style:TextStyle(fontSize: fontSize,fontWeight: fontWeight,color:color == null ? Colors.grey.shade900 : color),textAlign: textAlign);
  }
}