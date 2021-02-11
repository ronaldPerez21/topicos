import 'package:flutter/material.dart';
import 'package:registro_login/datosUsuarios.dart';
import 'package:registro_login/index.dart';
import 'package:registro_login/registrarse.dart';
import "package:firebase_core/firebase_core.dart" as firebase_core;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp();
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
