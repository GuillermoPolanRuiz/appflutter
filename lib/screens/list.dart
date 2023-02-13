import 'dart:convert';

import 'package:appflutter/screens/listData.dart';
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
            listClass(link: ListDataScreen(name: 'pueblos', text: 'Pueblos',), text: "Pueblos", icon: Icons.villa_rounded),
            listClass(link: ListDataScreen(name: 'lugares', text: 'Lugares',), text: "Lugares", icon: Icons.place),
          ],
         ),
      ),
    );
  }
}



class listClass extends StatelessWidget {
  final Widget link;
  final String text;
  final IconData icon;
  const listClass({
    Key? key, required this.link, required this.text, required this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
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