import 'dart:convert';

import 'package:flutter/widgets.dart';

class Sitio {
  final int id;
  final String name;
  final String desc;
  final String image;
  final String cor1;
  final String cor2;
  final String es;
  final String? price;
  final String? ubc;

  Sitio({
    required this.id,
    required this.name,
    required this.desc,
    required this.image,
    required this.cor1,
    required this.cor2,
    required this.es,
    this.price,
    this.ubc
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'image': image,
      'cor1': cor1,
      'cor2': cor2,
      'es': es,
      'price':price,
      'ubc':ubc
    };
  }

  factory Sitio.fromMap(Map<String, dynamic> map) {
    return Sitio(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      desc: map['desc'] ?? '',
      image: map['image'] ?? '',
      cor1: map['cor1'] ?? '',
      cor2: map['cor2'] ?? '',
      es: map['es'] ?? '',
      price: map['price'] ?? '',
      ubc: map['ubc'] ?? ''
    );
  }

  String toJson() => json.encode(toMap());

  factory Sitio.fromJson(String source) => Sitio.fromMap(json.decode(source));

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog(id: $id, name: $name, desc: $desc, image: $image, cor1: $cor1, cor2: $cor2, es: $es, price: $price, ubc: $ubc)';
  }
}