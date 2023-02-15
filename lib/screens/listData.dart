import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../entities/model.dart';


class ListDataScreen extends StatefulWidget{
  final String name;
  final String text;
  const ListDataScreen({ super.key, required this.name, required this.text});

  @override
  _ListDataScreen createState() => _ListDataScreen();
}

class _ListDataScreen extends State<ListDataScreen> {
  List _items = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.text}"),
      ),
      body: Column(
        children: [
          _items.isNotEmpty?Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                if (_items[index]["es"] == "true") { // Este if va ser para saber si es casa rural o lugar, pueblo...
                  return Card(
                    key: ValueKey(_items[index]["id"]),
                    margin: const EdgeInsets.all(10),
                    color: Color.fromARGB(255, 255, 251, 251),
                    elevation: 5,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(_items[index]["name"]),
                          subtitle: Text(_items[index]["desc"]),
                        ),
                        Image.network(_items[index]["image"], scale: 3),
                        ElevatedButton(onPressed: null, child: Text("Cómo llegar")) // Este llevará a Google Maps
                      ],
                    )
                  );
                }else{
                  return Card(
                    key: ValueKey(_items[index]["id"]),
                    margin: const EdgeInsets.all(10),
                    color: Color.fromARGB(255, 255, 251, 251),
                    elevation: 5,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(_items[index]["name"]),
                          subtitle: Text(_items[index]["ubc"] +""+ _items[index]["desc"] + "\nPrecio/noche: " + _items[index]["price"] + "€"),
                        ),
                        Image.network(_items[index]["image"], scale: 2),
                        ElevatedButton(onPressed: null, child: Text("Cómo llegar")) // Este llevará a Google Maps
                      ],
                    )
                  );
                }
              },
            ),
          ):Container()
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  Future<void> readJson() async{
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["${widget.name}"];
      //print("${_items.length}");
    });
  }
}