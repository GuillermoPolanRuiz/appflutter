import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../entities/model.dart';


class LugaresScreen extends StatefulWidget{
  const LugaresScreen({ super.key });

  @override
  _lugaresScreen createState() => _lugaresScreen();
}

class _lugaresScreen extends State<LugaresScreen> {

  List _items = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lugares"),
      ),
      body: Column(
        children: [
          _items.isNotEmpty?Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return Card(
                  key: ValueKey(_items[index]["id"]),
                  margin: const EdgeInsets.all(10),
                  color: Colors.amber.shade100,
                  child: ListTile(
                    title: Text(_items[index]["name"]),
                    subtitle: Text(_items[index]["cor"]),
                  ),
                );
              },
            ),
          ): ElevatedButton(
              onPressed: () {
                
              },
              child: Center(child: Text("Load Json")))
        ],
      ),
    );
  }
  

  Future<void> readJson() async{
    final String response = await rootBundle.loadString('assets/lugares.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["pueblos"];
      print("${_items.length}");
    });
  }
}