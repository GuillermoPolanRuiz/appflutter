import 'dart:convert';
import 'dart:ffi';
import 'package:appflutter/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
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
                    margin: const EdgeInsets.all(30),
                    color: Color.fromARGB(255, 255, 251, 251),
                    elevation: 5,
                    child: Column(
                      children: [
                        ListTile(
                          title: Row(children: [Text(
                              _items[index]["name"],
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ), Expanded(child: Column()),Icon(Icons.favorite_border_outlined), Container(margin: EdgeInsets.only(bottom: 30),)],),
                          subtitle: Text(_items[index]["desc"]),
                        ),
                        Image.network(_items[index]["image"], scale: 3),
                        btn(double.parse(_items[index]["cor1"]),double.parse(_items[index]["cor2"])) // Pasamos las cordenadas y devuelve el botón
                      ],
                    )
                  );
                }else{
                  return Card(
                    key: ValueKey(_items[index]["id"]),
                    margin: const EdgeInsets.all(30),
                    color: Color.fromARGB(255, 255, 251, 251),
                    elevation: 5,
                    child: Column(
                      children: [
                        ListTile(
                          title: Row(children: [Text(_items[index]["name"],
                          style: TextStyle(
                                fontSize: 20,
                              ),
                          ), Expanded(child: Column()),Icon(Icons.favorite_border_outlined), Container(margin: EdgeInsets.only(bottom: 30),)],),
                          subtitle: Text(_items[index]["ubc"] +""+ _items[index]["desc"] + "\nPrecio/noche: " + _items[index]["price"] + "€"),
                        ),
                        Image.network(_items[index]["image"], scale: 2),
                        btn(double.parse(_items[index]["cor1"]),double.parse(_items[index]["cor2"])) // Pasamos las cordenadas y devuelve el botón
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

  // Esta función es para utilizar Google Maps con las coordenadas

  Future<void> openMap(double latitude, double longitude) async {
     String mapUrl = '';
     mapUrl = 'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude&travelmode=driving';

     if (await canLaunchUrl(Uri.parse(mapUrl))) {
       await launchUrl(Uri.parse(mapUrl),mode: LaunchMode.externalApplication);
     } else {
       throw 'Could not open the map.';
     }
   }

  // Función para leer el JSON

  Future<void> readJson() async{
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["${widget.name}"];
      //print("${_items.length}");
    });
  }

  // Botón de cómo llegar en Google Maps

  TextButton btn(double latitude, double longitude){
    return TextButton(
            style: TextButton.styleFrom(backgroundColor: AppTheme.primary),
            onPressed: (){
              openMap(latitude, longitude);
            },
            child: Text("Cómo llegar", style: TextStyle(color: Colors.white),),
          );
  }

  
}
