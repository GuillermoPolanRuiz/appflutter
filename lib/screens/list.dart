import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:appflutter/entities/model.dart';
import 'package:flutter/services.dart' as rootBundle;

class ListScreen extends StatefulWidget{
  const ListScreen({ super.key });

  @override
  _ListScreen createState() => _ListScreen();
}

class _ListScreen extends State<ListScreen> {
   
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      body: const Center(
         child: Text('ListScreen'),
      ),
    );
  }

  Future<List<Model>> ReadJsonData() async{
    final jsondata = await rootBundle.rootBundle.loadString('assets/data.json');
    final list = jsonDecode(jsondata) as List<dynamic>;

    return list.map((e) => Model.fromJson(e)).toList();
  }
}