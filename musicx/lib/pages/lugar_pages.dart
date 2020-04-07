import 'package:flutter/material.dart';
import 'package:musicx/pages/lugar.dart';
import 'package:musicx/main.dart';
import 'package:musicx/src/models/lugar.models.dart';
import 'package:musicx/src/providers/lugares_providers.dart';

class Lugar_page extends StatelessWidget {
  
  final lugaresProviders = new LugaresProviders();
  @override
  Widget build(BuildContext context) {
    //final bloc = Provider.of(context);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Lugares Disponibles'),
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
        future: lugaresProviders.cargarLugar(),
        builder: (BuildContext context,
            AsyncSnapshot<List<LugarModel>> snapshot) {
          if (snapshot.hasData) {
            final lugares = snapshot.data;
            return ListView.builder(
              itemCount: lugares.length,
              itemBuilder: (context, i) => _crearItem(context, lugares[i]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
      );
  }

  Widget _crearItem(BuildContext context, LugarModel lugares){

    
    return Dismissible
    (key: UniqueKey(),
    background: Container(
      color: Colors.red,
    ),
    onDismissed: (direccion){
      //TODO: Borrar lugares
      lugaresProviders.borrarLugar(lugares.id);

    },
    child: ListTile(
      title: Text('Estado: ${lugares.estado} - Colonia: ${lugares.colonia}'),
      subtitle: Text('Pais: ${lugares.pais}'),
      onTap: () =>Navigator.pushNamed(context, 'lugares',arguments: lugares),
    ),
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.purple,
      onPressed: () => Navigator.pushNamed(context, 'lugares'),
    );
  }
}
