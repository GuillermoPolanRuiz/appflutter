import 'package:appflutter/screens/config.dart';
import 'package:appflutter/screens/list.dart';
import 'package:flutter/material.dart';
import 'package:appflutter/theme/app_theme.dart';
import 'package:is_first_run/is_first_run.dart';

class OpenScreen extends StatefulWidget {
  final bool first;
  const OpenScreen({ super.key, required this.first});

  @override
  State<OpenScreen> createState() => _OpenScreenState();
}

class _OpenScreenState extends State<OpenScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.first) {
      return FutureBuilder(
      future: _showDialog(context),
      builder: (context,snapshot) => Scaffold(
      body: Container(
        child: Column(
            children: <Widget>[
              // Texto superior
              Expanded(child: Column(
                children: [
                  Container(padding: const EdgeInsets.all(60),),
                  Text(
                    'TurisNA',
                    style: TextStyle(
                      fontSize: 50 ,
                      color: AppTheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              )),

              // Imagen de Navarra
              Expanded(child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/mapaNA.jpg'),
                    )
                  ),
                )
              ),

              // Botón para lista
              Expanded(child: Column(
                children: [
                  Container(padding: const EdgeInsets.all(30),),
                  Navegate(link: ListScreen())
                ],
                )
              ),

              // Botón de configuración
              Container(
                padding: EdgeInsets.only(bottom: 50),
                child: Column(
                children: [
                  ConfigBtn(link: ConfigScreen())
                ],
              ),
              )
            ],
          ),
      )
    )
      
    );
    }else{
      return Scaffold(
      body: Container(
        child: Column(
            children: <Widget>[
              // Texto superior
              Expanded(child: Column(
                children: [
                  Container(padding: const EdgeInsets.all(60),),
                  Text(
                    'TurisNA',
                    style: TextStyle(
                      fontSize: 50 ,
                      color: AppTheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              )),

              // Imagen de Navarra
              Expanded(child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/mapaNA.jpg'),
                    )
                  ),
                )
              ),

              // Botón para lista
              Expanded(child: Column(
                children: [
                  Container(padding: const EdgeInsets.all(30),),
                  Navegate(link: ListScreen())
                ],
                )
              ),

              // Botón de configuración
              Container(
                padding: EdgeInsets.only(bottom: 50),
                child: Column(
                children: [
                  ConfigBtn(link: ConfigScreen())
                ],
              ),
              )
            ],
          ),
      )
    );
    
    }
  }

  

  Future<void> _showDialog(BuildContext context) async {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Container(
            height: 300,
            width: 300,
            child: Column(
              children: [
                Text("Bienvenido a TurisNA", style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold, fontSize: 20)),
                Expanded(child: Column(
                children: [
                  Container(padding: const EdgeInsets.all(30),),
                  Text("Esta aplicación tiene como funcionalidad guiar y satisfacer las necesidades de aquellas personas que deseen visitar el ambiente Navarro."),
                  Container(padding: const EdgeInsets.all(15),),
                  Text("Se mostrará información de lugares, pueblos, casas rurales e incluso de museos de Navarra."),
                  Container(padding: const EdgeInsets.all(15),),
                  Text("¡Gracias!", style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold, fontSize: 20))
                  ],
                  )
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cerrar', style: TextStyle(color: AppTheme.primary),),
            ),
          ],
        ),
      );
    });
  }

}




// Clase para el Scroll de inicio
class ScrollScreen extends StatelessWidget {
  final bool first;
  const ScrollScreen({ super.key, required this.first});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: [
          OpenScreen(first: first,),
          ListScreen()
        ],
      ),
    );
  }
}



// Clase para el botón rojo de avanzar

class Navegate extends StatelessWidget {
  final Widget link;
  const Navegate({
    Key? key, required this.link,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: AppTheme.primary,
        minimumSize: const Size(150, 100),
        elevation: 20,
      ),
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => link
            )
        ),
      child: const Icon(
        Icons.arrow_circle_right_sharp,
        size: 60,
        )
    );
  }
}


// Clase para el Screen de configuración
class ConfigBtn extends StatelessWidget {
  final Widget link;
  const ConfigBtn({
    Key? key, required this.link,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: AppTheme.primary,
        minimumSize: const Size(20, 20),
        elevation: 20,
      ),
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => link
            )
        ),
      child: const Icon(
        Icons.settings,
        size: 40,
        )
    );
  }
}