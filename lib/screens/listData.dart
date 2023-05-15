import 'dart:convert';
import 'dart:ffi';
import 'package:appflutter/entities/database.dart';
import 'package:appflutter/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:like_button/like_button.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../entities/model.dart';
import '../entities/database.dart';
import 'package:http/http.dart' as http;


class ListDataScreen extends StatefulWidget{
  final String name;
  final String text;
  const ListDataScreen({ super.key, required this.name, required this.text});

  @override
  _ListDataScreen createState() => _ListDataScreen();
}

class _ListDataScreen extends State<ListDataScreen> {
  final DatabaseService _db = DatabaseService();
  List _items = [];
  List<Sitio> _itemsFav = [];
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
                              utf8.decode(_items[index]["name"].toString().runes.toList()),
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ), Expanded(child: Column()),
                            likeBtn(
                              _items[index]["id"],
                              utf8.decode(_items[index]["name"].toString().runes.toList()),
                              utf8.decode(_items[index]["desc"].toString().runes.toList()),
                              _items[index]["image"],
                              _items[index]["cor1"],
                              _items[index]["cor2"],
                              _items[index]["es"],
                              "",""
                            ), 
                            //Container(margin: EdgeInsets.only(bottom: 30),)
                            ],),
                          //subtitle: Text(_items[index]["desc"]),
                          subtitle: getReadMore(utf8.decode(_items[index]["desc"].toString().runes.toList())),
                        ),
                        CachedNetworkImage(imageUrl: _items[index]["image"], placeholder: (context, url) => new CircularProgressIndicator(color: AppTheme.BGcolor,backgroundColor: AppTheme.primary,strokeWidth: 8,),),
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
                          title: Row(children: [Text(
                              utf8.decode(_items[index]["name"].toString().runes.toList()),
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ), Expanded(child: Column()),
                          likeBtn(
                            _items[index]["id"],
                              utf8.decode(_items[index]["name"].toString().runes.toList()),
                              utf8.decode(_items[index]["desc"].toString().runes.toList()),
                              _items[index]["image"].toString(),
                              _items[index]["cor1"].toString(),
                              _items[index]["cor2"].toString(),
                              _items[index]["es"].toString(),
                              _items[index]["price"].toString(),
                              utf8.decode(_items[index]["ubc"].toString().runes.toList())
                          ), Container(margin: EdgeInsets.only(bottom: 30),)],),
                          subtitle: Text(utf8.decode(_items[index]["ubc"].toString().runes.toList()) +""+ utf8.decode(_items[index]["desc"].toString().runes.toList()) + "\nPrecio/noche: " + _items[index]["price"] + "€"),
                        ),
                        //Image.network(_items[index]["image"], scale: 2),
                        CachedNetworkImage(imageUrl: _items[index]["image"], placeholder: (context, url) => new CircularProgressIndicator(color: AppTheme.BGcolor,backgroundColor: AppTheme.primary,strokeWidth: 8,),),
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

  Container getReadMore(String text){
    return Container(
      child: ReadMoreText(
        text,
        trimLines: 2,
        trimMode: TrimMode.Line,
        trimCollapsedText: " Ver más ",
        trimExpandedText: " Ver menos ",
        lessStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppTheme.primary
        ),
        moreStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppTheme.primary
        ),
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  List<Sitio> getAll() {
    List<Sitio> _listProducts = [];
    _db.favs().then((value) {
      if (value != null) value.forEach((item) => _listProducts.add(item));
    });
    return _listProducts == null ? [] : _listProducts;
  }
  
  bool verifyID(id){
    for (var e in _itemsFav) {
      if (e.id == id) {
        return true;
      }
    }
    return false;
  }
  

  LikeButton likeBtn(id,name,desc,image,cor1,cor2,es,price,ubc){
    if (verifyID(int.parse(id))) {
      return LikeButton(
      animationDuration: Duration(milliseconds: 1000),
      isLiked: true,
    );
    }else{
      return LikeButton(
      animationDuration: Duration(milliseconds: 1000),
      likeBuilder: (isLiked) {
        if (isLiked == true) {
          // Leer y escribir si es favorito en un json 
          Sitio sitio = new Sitio(id:int.parse(id), name: name, desc: desc, image: image, cor1: cor1, cor2: cor2, es: es, price: price, ubc: ubc);
          _db.insertSitio(sitio);
        }
      },
    );
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      readJson();
    });
    
    _itemsFav = getAll();
  }
  

  // Esta función es para utilizar Google Maps con las coordenadas

  Future<void> openMap(double latitude, double longitude) async {
     String mapUrl = '';
     mapUrl = 'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude&travelmode=driving';

     if (await canLaunchUrl(Uri.parse(mapUrl))) {
       await launchUrl(Uri.parse(mapUrl),mode: LaunchMode.externalApplication);
     } else {
       throw 'No se ha podido abrir';
     }
   }

  // Función para leer el JSON

  Future<void> readJson() async{
    showDialog(
      context: this.context, 
      builder: (context){
        return Center(
          child: CircularProgressIndicator(
            color: AppTheme.BGcolor,
            backgroundColor: AppTheme.primary,
            strokeWidth: 10,
          ),
        );
    });

    final response = await http.get(Uri.parse('https://apimocha.com/proyectodam/data'));
    final data = await json.decode(response.body);
    setState(() {
      _items = data["${widget.name}"];
    });
    Navigator.of(this.context).pop();

    
  }

  

  //final String response2 = await rootBundle.loadString('assets/data.json');
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
