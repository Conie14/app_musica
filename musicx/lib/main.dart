import 'package:flutter/material.dart';
import 'package:musicx/pages/cliente.dart';
import 'package:musicx/pages/banda.dart';
import 'package:musicx/pages/lugar.dart';

import 'home.dart';

void main() => runApp(Aplication());

class Aplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title:'Music X',
      home: Home(),
      routes: {
        'cliente':(BuildContext context) => Cliente(),
        'banda':(BuildContext context) => Banda(),
        'lugares':(BuildContext context) => Lugar()

      },
      theme: ThemeData(
        primaryColor: Color(0xFF2F00BE),
        accentColor: Color(0xFFFDD303)
      )
    );
  }
}