import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Registro extends StatefulWidget {
  Registro({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Registro> {

  File image;
  final picker = ImagePicker();
  
  TextEditingController nombre;
  TextEditingController apellido;
  TextEditingController telefono;
  TextEditingController direccion;
  TextEditingController nombreUsuario;
  TextEditingController contraUsuario;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("REGISTRO"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            child: ListView(
              children: <Widget>[
                TextFormField(
                  controller: nombre,
                  decoration: InputDecoration(
                    labelText: "Nombre"
                  ),
                  validator: (value){ if(value.isEmpty) return "Campo vacio"; }
                ),

                TextFormField(
                  controller: apellido,
                  decoration: InputDecoration(
                    labelText: "Apellido"
                  ),
                  validator: (value){ if(value.isEmpty) return "Campo vacio"; }
                ),

                TextFormField(
                  controller: telefono,
                  decoration: InputDecoration(
                    labelText: "Teléfono"
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value){ if(value.isEmpty) return "Campo vacio"; }
                ),

                TextFormField(
                  controller: direccion,
                  decoration: InputDecoration(
                    labelText: "Dirección"
                  ),
                  validator: (value){ if(value.isEmpty) return "Campo vacio"; }
                ),

                TextFormField(
                  controller: nombreUsuario,
                  decoration: InputDecoration(
                    labelText: "Nombre de usuario"
                  ),
                  validator: (value){ if(value.isEmpty) return "Campo vacio"; }
                ),

                TextFormField(
                  controller: contraUsuario,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Contraseña"
                  ),
                  validator: (value){ if(value.isEmpty) return "Campo vacio"; }
                ),
                IconButton(
                  icon: Icon(Icons.camera),
                  onPressed: (){
                    choiceImage();
                  },
                ),
                Container(
                  width: 100,
                  height: 100,
                  child: image == null ? Center(child: Text("Imagen no seleccionada")): Image.file(image)
                ),
                RaisedButton(
                  child: Text("Registrarse", style: TextStyle(color: Colors.black)),
                  color: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  onPressed: (){ 
                    upLoadImage();
                    //_alertDialog(context);
                    Navigator.of(context).pushNamedAndRemoveUntil('/', (Route <dynamic> route) => false);
                  },
                )

              ],
            )
          )
        ),
      ),
    );
  }

  Future choiceImage() async{
    try{
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    
    setState((){
      image = File(pickedImage.path);
    });
    }catch(Exception ) { print("Error"); }
  }

  Future upLoadImage() async {
    final uri = Uri.parse("http://192.168.56.1/registro_login/registro.php");
    var request = http.MultipartRequest("POST", uri);
    request.fields["nom"] = nombre.text;
    request.fields["apel"] = apellido.text;
    request.fields["telf"] = telefono.text;
    request.fields["dir"] = direccion.text;
    request.fields["nomUser"] = nombreUsuario.text;
    request.fields["contra"] = contraUsuario.text;

    var pic = await http.MultipartFile.fromPath("imagen", image.path);
    request.files.add(pic);
    var response = await request.send();

    if(response.statusCode == 200) print("Image upload");
    else print("Image not upload");

    setState(() {
      
    });
  }

  @override
  void initState() {
    super.initState();
    nombre = new TextEditingController();
    apellido = new TextEditingController();
    telefono = new TextEditingController();
    direccion = new TextEditingController();
    nombreUsuario = new TextEditingController();
    contraUsuario = new TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nombre.dispose();
    apellido.dispose();
    telefono.dispose();
    direccion.dispose();
    nombreUsuario.dispose();
    contraUsuario.dispose();
  }

  void _alertDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Mensaje de registro"),
          content: Text("Usuario registrado correctamente"),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
        );
      }, 
    );
  }
}
