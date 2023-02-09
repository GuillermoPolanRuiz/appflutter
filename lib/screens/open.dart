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
              mainForm(),

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
  
  mainForm() {
    return Form(
          key: _formKey,
          child:
          Column(children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 3) {
                return 'Min 3 caracteres';
              }
                return null;
              },
            decoration: const InputDecoration(
              icon: Icon(Icons.supervised_user_circle),
              hintText: "Nombre de usuario",
              labelText: "Nombre",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10))
              ),
              suffixIcon: Icon(Icons.supervised_user_circle),
              counterText: "3 carácteres"
            ),
          ),

          Container(padding: const EdgeInsets.all(10),),

          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 6) {
                return 'Min 6 caracteres';
              }
                return null;
              },
            obscureText: true,
            decoration: const InputDecoration(
              icon: Icon(Icons.supervised_user_circle),
              hintText: "Contraseña",
              labelText: "Contraseña",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10))
              ),
              suffixIcon: Icon(Icons.supervised_user_circle),
              counterText: "6 carácteres"
            ),
          ),


          Container(padding: const EdgeInsets.all(10),),

          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cargando Formulario')),
              );
              }
            },
            child: const Text('Aceptar'),
          ),
        ],
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