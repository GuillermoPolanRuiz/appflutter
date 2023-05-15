import 'package:appflutter/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}


class _ConfigScreenState extends State<ConfigScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configuración"),
      ),
      body: Container( // Varias Rows para cada texto
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 20,),
            Row(
              children: [
                Icon(Icons.account_circle),
                SizedBox(width: 10,),
                Text("Información", style: TextStyle(fontSize: 22,),)
              ],
            ),
            Divider(height: 20, thickness: 1,),
            SizedBox(height: 20,),
            
            // Tabla con la información de la aplicación
            Container(
              padding: EdgeInsets.only(left: 30),
              child: Table(
              children: [
                TableRow(
                  children: [
                    //SizedBox(width: 1,),
                    TableCell(child: getText("Versión")),
                    TableCell(child: getText("Fecha de actualización")),
                  ]
                ),

                TableRow(
                  children: [
                    //SizedBox(width: 1,),
                    TableCell(child: Padding(padding: EdgeInsets.only(bottom: 40), child: Text("1.0", style: TextStyle(fontSize: 12)),)),
                    TableCell(child: Text(DateTime.now().day.toString() + "/" + DateTime.now().month.toString() + "/" + DateTime.now().year.toString(), style: TextStyle(fontSize: 12))),
                  ]
                ),
                
                TableRow(
                  children: [
                    TableCell(child: getText("Correo desarrollador")),
                    TableCell(child: getText("Ofrecido por")),
                  ]
                ),

                TableRow(
                  children: [
                    TableCell(child: Text("guillepolanruiz@gmail.com", style: TextStyle(fontSize: 12))),
                    TableCell(child: Text("Guillermo Polán Ruiz", style: TextStyle(fontSize: 12))),
                  ]
                )
              ],
            ),
            )
          ],
        ),
      ),
    );
  }


  Text getText(String text){
    return Text(text, style: TextStyle(fontSize: 15));
  }
}
