import 'package:appflutter/entities/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../entities/model.dart';
import '../theme/app_theme.dart';

class ListDataFav extends StatefulWidget {
  const ListDataFav({super.key});

  @override
  State<ListDataFav> createState() => _ListDataFavState();
}

class _ListDataFavState extends State<ListDataFav> {
  @override
  

  final DatabaseService _db = DatabaseService();
  @override
  Widget build(BuildContext context) {return Scaffold(
      appBar: AppBar(title: Text("Favoritos")),
      body: FutureBuilder<List<Dog>>(
      future: _db.dogs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data!.length == 0) {
          return Center(child: Text("No se encuentran registros."),);
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final dog = snapshot.data![index];
              if (dog.price == "") {
                return Card(
                    key: ValueKey(dog.id),
                    margin: const EdgeInsets.all(30),
                    color: Color.fromARGB(255, 255, 251, 251),
                    elevation: 5,
                    child: Column(
                      children: [
                        ListTile(
                          title: Row(children: [Text(
                              dog.name,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ), Expanded(child: Column()),
                            ElevatedButton(
                              onPressed: () {
                                _showMyDialog(dog.id, dog.name);
                              }, 
                              child: Icon(Icons.delete),
                              style: ElevatedButton.styleFrom(
                                primary: AppTheme.primary,
                                minimumSize: const Size(10, 20),
                              ),
                            ),
                            Container(margin: EdgeInsets.only(bottom: 30),)],),
                          subtitle: Text(dog.desc),
                        ),
                        Image.network(dog.image, scale: 3),
                        btn(double.parse(dog.cor1),double.parse(dog.cor2)) // Pasamos las cordenadas y devuelve el botón
                      ],
                    )
              );
              }else{
                return Card(
                    key: ValueKey(dog.id),
                    margin: const EdgeInsets.all(30),
                    color: Color.fromARGB(255, 255, 251, 251),
                    elevation: 5,
                    child: Column(
                      children: [
                        ListTile(
                          title: Row(children: [Text(
                              dog.name,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ), Expanded(child: Column()),
                            ElevatedButton(
                              onPressed: () {
                                _showMyDialog(dog.id, dog.name);
                              }, 
                              child: Icon(Icons.delete),
                              style: ElevatedButton.styleFrom(
                                primary: AppTheme.primary,
                                minimumSize: const Size(10, 20),
                              ),
                            ),
                            Container(margin: EdgeInsets.only(bottom: 30),)],),
                          subtitle: Text(dog.ubc.toString() +""+ dog.desc + "\nPrecio/noche: " + dog.price.toString() + "€"),
                        ),
                        Image.network(dog.image, scale: 3),
                        btn(double.parse(dog.cor1),double.parse(dog.cor2)) // Pasamos las cordenadas y devuelve el botón
                      ],
                    )
                  
              );
              }
            },
          ),
        );
      },
    )
    );
  }

  Future<void> _showMyDialog(id, name) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Eliminar registro'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('¿Desea eliminar el siguiente registro?'),
              Text("\n"+name),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Sí'),
            onPressed: () {
              setState(() {
                Navigator.of(context).pop();
                delete(id);
              });
            },
          ),
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

  void initState() {
    super.initState();
  }

Future<void> openMap(double latitude, double longitude) async {
     String mapUrl = '';
     mapUrl = 'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude&travelmode=driving';

     if (await canLaunchUrl(Uri.parse(mapUrl))) {
       await launchUrl(Uri.parse(mapUrl),mode: LaunchMode.externalApplication);
     } else {
       throw 'Could not open the map.';
     }
   }

TextButton btn(double latitude, double longitude){
    return TextButton(
            style: TextButton.styleFrom(backgroundColor: AppTheme.primary),
            onPressed: (){
              openMap(latitude, longitude);
            },
            child: Text("Cómo llegar", style: TextStyle(color: Colors.white),),
          );
  }
  void delete(id){
    _db.deleteDog(id);
  }

}


