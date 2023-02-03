import 'package:flutter/material.dart';

class Model{
  String? title;
  String? text; 

  Model(this.title, this.text);
  
  Model.fromJson(Map<String, dynamic> json){
    title = json['Title'];
    text = json['Text'];
  }
  
}