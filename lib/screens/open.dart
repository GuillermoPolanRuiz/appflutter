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
                  Container(padding: const EdgeInsets.all(40),),
                  Text('\n__________________________'),
                  Text(
                    'SearchNA',
                    style: TextStyle(
                      fontSize: 35 ,
                      color: AppTheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text('__________________________'),
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



// Clase para el botón rojo

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