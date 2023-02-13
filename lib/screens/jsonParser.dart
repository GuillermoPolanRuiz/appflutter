import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class jsonParser extends StatefulWidget {
  final String name;
  final String text;
  const jsonParser(this.name,this.text);
  

  @override
  jsonParserState createState() => jsonParserState();
}

class jsonParserState extends State<jsonParser> {
  @override
  Widget build(BuildContext context) {
    return Text(""); 
  }
  List _items = [];
  Future<void> readJson() async{
    final String response = await rootBundle.loadString('assets/lugares.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["pueblos"];
      print("${_items.length}");
    });
  }

  
}



