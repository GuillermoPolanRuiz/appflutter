import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
   
  const ListScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        backgroundColor: Color.fromARGB(255, 230, 49, 76),
      ),
      body: const Center(
         child: Text('ListScreen'),
      ),
    );
  }
}