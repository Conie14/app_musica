import 'package:flutter/material.dart';
import 'package:musicx/src/models/lugar.models.dart';
import 'package:musicx/src/providers/lugares_providers.dart';
import 'package:musicx/src/utils/utils.dart' as utils;

class Lugar extends StatefulWidget {
  @override
  _LugarState createState() => _LugarState();
}

class _LugarState extends State<Lugar> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //Video

  LugarModel lugar = new LugarModel();
  final lugaresProviders = new LugaresProviders();
  bool _guardando = false;
  @override
  Widget build(BuildContext context) {
    final LugarModel proData = ModalRoute.of(context).settings.arguments;
    if (proData != null) {
      lugar = proData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Registro del lugar'),
       /* actions: <Widget>[
          IconButton(
              icon: Icon(Icons.photo_size_select_actual), onPressed: () {}),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
        ],*/
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                  //Pais, estado,codigop, calle,colonia

                _crearPais(),
                _crearEstado(),
                _crearCodigoP(),
                _crearCalle(),
                _crearColonia(),
                _crearDisponible(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
//-------------------------------------------------------//
  Widget _crearPais() {
    return TextFormField(
      //video
      initialValue: lugar.pais,

      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Pais'),
      onSaved: (value) => lugar.pais = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el pais';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearEstado() {
    return TextFormField(
      //video
      initialValue: lugar.estado,

      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Estado'),
      onSaved: (value) => lugar.estado = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el estado';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearCodigoP() {
    return TextFormField(
      initialValue: lugar.codigop.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      decoration: InputDecoration(labelText: 'Codigo Postal'),
      onSaved: (value) => lugar.codigop = int.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo números';
        }
      },
    );
  }

   Widget _crearCalle() {
    return TextFormField(
      //video
      initialValue: lugar.calle,

      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'calle del lugar'),
      onSaved: (value) => lugar.calle = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese la calle';
        } else {
          return null;
        }
      },
    );
  }

   Widget _crearColonia() {
    return TextFormField(
      //video
      initialValue: lugar.colonia,

      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Colonia'),
      onSaved: (value) => lugar.colonia = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese la colonia';
        } else {
          return null;
        }
      },
    );
  }

//-------------------------------------------------------//

  Widget _crearDisponible() {
    return SwitchListTile(
        value: lugar.disponible,
        title: Text('disponible'),
        activeColor: Colors.deepPurple,
        onChanged: (value) => setState(() {
              lugar.disponible = value;
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

  void _submit() {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if (lugar.id == null) {
      
      lugaresProviders.crearLugar(lugar);
    } else {
      lugaresProviders.editarLugar(lugar);
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
}
