import 'dart:convert';

import 'package:appflutter/screens/listData.dart';
import 'package:appflutter/theme/app_theme.dart';
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
      body: Center(
         child: ListView(
          children: const [
            ListClass(link: ListDataScreen(name: 'lugares', text: 'Lugares',), text: "Lugares", icon: Icons.place),
            ListClass(link: ListDataScreen(name: 'pueblos', text: 'Pueblos',), text: "Pueblos", icon: Icons.location_city),
            ListClass(link: ListDataScreen(name: 'casasRurales', text: 'Casas Rurales',), text: "Casas Rurales", icon: Icons.villa_rounded),
            ListClass(link: ListDataScreen(name: 'museos', text: 'Museos'), text: 'Museos', icon: Icons.museum_rounded),
            
            // Favoritos

          ],
         ),
      ),
    );
  }
}



// Clase para generar un ListTile con el link a la Screen, texto e icono
class ListClass extends StatelessWidget {
  final Widget link;
  final String text;
  final IconData icon;
  const ListClass({
    Key? key, required this.link, required this.text, required this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
        color: AppTheme.primary,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
      
      trailing: const Icon(Icons.navigate_next),
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => link
            )
        )
      }

    );
  }
}