import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:musicx/pages/banda.dart';
import 'package:musicx/main.dart';
import 'package:musicx/src/models/banda.models.dart';
import 'package:musicx/src/providers/bandas_providers.dart';

class Banda_page extends StatelessWidget {
  final bandasProviders = new BandasProviders();
  @override
  Widget build(BuildContext context) {
    //final bloc = Provider.of(context);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Bandas'),
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
        future: bandasProviders.cargarBanda(),
        builder:
            (BuildContext context, AsyncSnapshot<List<BandaModel>> snapshot) {
          if (snapshot.hasData) {
            final bandas = snapshot.data;
            return ListView.builder(
              itemCount: bandas.length,
              itemBuilder: (context, i) => _crearItem(context, bandas[i]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearItem(BuildContext context, BandaModel banda) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direccion) {
          //TODO: Borrar banda
          bandasProviders.borrarBanda(banda.id);
        },
        child: Card(
          child: Column(
            children: <Widget>[
              (banda.fotoUrl == null)
                  ? Image(image: AssetImage('assets/no.png'))
                  : FadeInImage(
                      image: NetworkImage(banda.fotoUrl),
                      placeholder: AssetImage('assets/jar.gif'),
                      height: 300.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              ListTile(
                title: Text(
                    'Nombre: ${banda.nombre} - Integrantes: ${banda.integrantes}'),
                subtitle: Text(banda.correo),
                onTap: () =>
                    Navigator.pushNamed(context, 'banda', arguments: banda),
              ),
            ],
          ),
        ));

    /*
     ListTile(
      title: Text('Nombre: ${banda.nombre} - Integrantes: ${banda.integrantes}'),
      subtitle: Text(banda.correo),
      onTap: () =>Navigator.pushNamed(context, 'banda',arguments: banda),
    ),
    */
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.blue,
      onPressed: () => Navigator.pushNamed(context, 'banda'),
    );
  }
}
