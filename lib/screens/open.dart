import 'package:appflutter/screens/config.dart';
import 'package:appflutter/screens/list.dart';
import 'package:flutter/material.dart';
import 'package:appflutter/theme/app_theme.dart';

class OpenScreen extends StatefulWidget {
  const OpenScreen({super.key});

  @override
  State<OpenScreen> createState() => _OpenScreenState();
}

class _OpenScreenState extends State<OpenScreen> {
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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

              // Botón rojo
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


// Clase para el Scroll de inicio
class ScrollScreen extends StatelessWidget {
  const ScrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: [
          OpenScreen(),
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