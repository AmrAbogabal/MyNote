import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BoxDecoration ContinerStyle(Color c){
  return BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: c
  );
}
Text MyTextStyle(String S){
  return Text(S,style: TextStyle(
  ),) ;
}
dynamic SectionColor(index,selected){
  if(index==0){
    return Colors.white ;
  }
  else {
    if(index==selected){
      return Colors.green ;
    }
    else {
      return Colors.white ;
    }
  }
}