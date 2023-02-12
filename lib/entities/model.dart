import 'package:flutter/material.dart';

class Model{
  String? name;
  String? cor; 

  Model(this.name, this.cor);
  
  Model.fromJson(Map<String, dynamic> json){
    name = json['name'];
    cor = json['cor'];
  }
  
}