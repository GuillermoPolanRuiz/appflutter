import 'package:appflutter/screens/list.dart';
import 'package:flutter/material.dart';
import 'package:appflutter/theme/app_theme.dart';

class OpenScreen extends StatelessWidget {
   
  const OpenScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppTheme.primary,
        child: Column(
            children: <Widget>[
              Expanded(child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('logoNA.jpg'),
                    )
                  ),
                )
              ),
              Expanded(child: Column(
                children: const [
                  Text('\n__________________________'),
                  Text(
                    'Buscador de cultura\nen Navarra',
                    style: TextStyle(
                      fontSize: 35 ,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text('__________________________'),
                ],
              )),


              // Aquí hay que hacer el formulario de login/register


              Expanded(child: Column(
                children: const [
                  Navegate(link: ListScreen())
                ],
                )
              )
            ],
          ),
      )
    );
  }

}



class Navegate extends StatelessWidget {
  final Widget link;
  const Navegate({
    Key? key, required this.link,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
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
        color: Color.fromARGB(255, 230, 49, 76),
        )
    );
  }
}