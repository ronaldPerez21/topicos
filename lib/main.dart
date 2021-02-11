import 'package:flutter/material.dart';
import 'package:registro_login/datosUsuarios.dart';
import 'package:registro_login/index.dart';
import 'package:registro_login/registrarse.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: "/",
      routes: {
        "/": (BuildContext context) => Index(),
        "/registrarse": (BuildContext context) => Registro(),
        "/datoUsuario": (BuildContext context) => DatosUsuarios()
      },
    );
  }
}
