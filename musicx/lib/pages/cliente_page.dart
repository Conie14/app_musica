import 'package:flutter/material.dart';
import 'package:musicx/pages/cliente.dart';
import 'package:musicx/main.dart';
import 'package:musicx/src/models/cliente.models.dart';
import 'package:musicx/src/providers/clientes_providers.dart';

class Cliente_page extends StatelessWidget {
  
  final clientesProviders = new ClientesProviders();
  @override
  Widget build(BuildContext context) {
    //final bloc = Provider.of(context);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes'),
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
        future: clientesProviders.cargarCliente(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ClienteModel>> snapshot) {
          if (snapshot.hasData) {
            final clientes = snapshot.data;
            return ListView.builder(
              itemCount: clientes.length,
              itemBuilder: (context, i) => _crearItem(context, clientes[i]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
      );
  }

  Widget _crearItem(BuildContext context, ClienteModel cliente){

    
    return Dismissible
    (key: UniqueKey(),
    background: Container(
      color: Colors.red,
    ),
    onDismissed: (direccion){
      //TODO: Borrar cliente
      clientesProviders.borrarCliente(cliente.id);

    },
    child: ListTile(
      title: Text('Nombre: ${cliente.nombre} - Edad: ${cliente.edad}'),
      subtitle: Text(cliente.correo),
      onTap: () =>Navigator.pushNamed(context, 'cliente',arguments: cliente),
    ),
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.blue,
      onPressed: () => Navigator.pushNamed(context, 'cliente'),
    );
  }
}
