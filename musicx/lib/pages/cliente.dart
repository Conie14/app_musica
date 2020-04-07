import 'package:flutter/material.dart';
import 'package:musicx/src/models/cliente.models.dart';
import 'package:musicx/src/providers/clientes_providers.dart';
import 'package:musicx/src/utils/utils.dart' as utils;

class Cliente extends StatefulWidget {
  @override
  _ClienteState createState() => _ClienteState();
}

class _ClienteState extends State<Cliente> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //Video

  ClienteModel cliente = new ClienteModel();
  final clientesProviders = new ClientesProviders();
  bool _guardando = false;
  @override
  Widget build(BuildContext context) {
    final ClienteModel proData = ModalRoute.of(context).settings.arguments;
    if (proData != null) {
      cliente = proData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Registro del Cliente'),
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
                _crearNombre(),
                _crearApellido(),
                _crearEdad(),
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
      initialValue: cliente.nombre,

      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Nombre del Cliente'),
      onSaved: (value) => cliente.nombre = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del cliente';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearApellido() {
    return TextFormField(
      //video
      initialValue: cliente.apellido,

      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Apellidos del Cliente'),
      onSaved: (value) => cliente.apellido = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el apellido del cliente';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearEdad() {
    return TextFormField(
      initialValue: cliente.edad.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      decoration: InputDecoration(labelText: 'Edad del cliente'),
      onSaved: (value) => cliente.edad = int.parse(value),
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
      initialValue: cliente.correo,

      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Correo del Cliente'),
      onSaved: (value) => cliente.correo = value,
      validator: (value) {
        if (value.length < 8) {
          return 'Ingrese el correo del cliente';
        } else {
          return null;
        }
      },
    );
  }

   Widget _crearTelefono() {
    return TextFormField(
      initialValue: cliente.telefono.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      decoration: InputDecoration(labelText: 'Telefono del cliente'),
      onSaved: (value) => cliente.telefono = int.parse(value),
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
        value: cliente.disponible,
        title: Text('disponible'),
        activeColor: Colors.deepPurple,
        onChanged: (value) => setState(() {
              cliente.disponible = value;
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

    if (cliente.id == null) {
      
      clientesProviders.crearCliente(cliente);
    } else {
      clientesProviders.editarCliente(cliente);
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
