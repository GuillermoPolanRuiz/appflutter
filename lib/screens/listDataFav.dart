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
  var text = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favoritos")),
      body: FutureBuilder<List<Dog>>(
      future: _db.dogs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final dog = snapshot.data![index];
              return Card(
                child: Card(
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
                              onPressed: null, // delete(dog.id), 
                              child: Icon(Icons.delete)
                            ),
                            Container(margin: EdgeInsets.only(bottom: 30),)],),
                          subtitle: Text(dog.desc),
                        ),
                        Image.network(dog.image, scale: 3),
                        btn(double.parse(dog.cor1),double.parse(dog.cor2)) // Pasamos las cordenadas y devuelve el botón
                      ],
                    )
                  ),
              );
            },
          ),
        );
      },
    )
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


