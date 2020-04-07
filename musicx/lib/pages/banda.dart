import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musicx/src/models/banda.models.dart';
import 'package:musicx/src/providers/bandas_providers.dart';
import 'package:musicx/src/utils/utils.dart' as utils;

class Banda extends StatefulWidget {
  @override
  _BandaState createState() => _BandaState();
}

class _BandaState extends State<Banda> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //Video

  BandaModel banda = new BandaModel();
  final bandasProviders = new BandasProviders();
  bool _guardando = false;
  File foto;
  @override
  Widget build(BuildContext context) {
    final BandaModel proData = ModalRoute.of(context).settings.arguments;
    if (proData != null) {
      banda = proData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Registro de la Banda'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.photo_size_select_actual),
               onPressed: _seleccionarFoto,
               ),
          IconButton(icon: Icon(Icons.camera_alt),
           onPressed: _tomarFoto,
           ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                _crearNombre(),
                _crearGenero(),
                _crearIntegrantes(),
                _crearCorreo(),
                _crearTelefono(),
                _crearDisponible(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      //video
      initialValue: banda.nombre,

      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Nombre del banda'),
      onSaved: (value) => banda.nombre = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del banda';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearGenero() {
    return TextFormField(
      //video
      initialValue: banda.genero,

      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Genero del banda'),
      onSaved: (value) => banda.genero = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el Genero del banda';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearIntegrantes() {
    return TextFormField(
      initialValue: banda.integrantes.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      decoration: InputDecoration(labelText: 'Integrantes del banda'),
      onSaved: (value) => banda.integrantes = int.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo números';
        }
      },
    );
  }

   Widget _crearCorreo() {
    return TextFormField(
      //video
      initialValue: banda.correo,

      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Correo del banda'),
      onSaved: (value) => banda.correo = value,
      validator: (value) {
        if (value.length < 8) {
          return 'Ingrese el correo del banda';
        } else {
          return null;
        }
      },
    );
  }

   Widget _crearTelefono() {
    return TextFormField(
      initialValue: banda.telefono.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      decoration: InputDecoration(labelText: 'Telefono del banda'),
      onSaved: (value) => banda.telefono = int.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo números';
        }
      },
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
        value: banda.disponible,
        title: Text('disponible'),
        activeColor: Colors.deepPurple,
        onChanged: (value) => setState(() {
              banda.disponible = value;
            }));
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.blue,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed:(_guardando)?null: _submit,
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if(foto != null){
      banda.fotoUrl = await bandasProviders.subirImagen(foto);
    }

    if (banda.id == null) {
      
      bandasProviders.crearBanda(banda);
    } else {
      bandasProviders.editarBanda(banda);
    }
    setState(() {
         _guardando = false;

    });

    mostrarSnackbar('Registro guardado');
    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 2000),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

Widget _mostrarFoto(){
  if(banda.fotoUrl != null){
    return FadeInImage(
      image: NetworkImage(banda.fotoUrl),
      placeholder: AssetImage('assets/jar.gif'),
      height: 300.0,
      fit: BoxFit.contain,
    );
  }else{
    return Image(
      image: AssetImage(foto?.path ?? 'assets/no.png'),
      height: 300.0,
      fit: BoxFit.cover,
    );
  }
}

  _seleccionarFoto() async {
    foto = await ImagePicker.pickImage(
      source:ImageSource.gallery
       );
       if(foto != null){
         banda.fotoUrl = null;
       }
       setState(() {});
  }

 _tomarFoto() async {
   foto = await ImagePicker.pickImage(
      source:ImageSource.camera
       );
       if(foto != null){
        banda.fotoUrl = null;
       }
       setState(() {});
 }



}
