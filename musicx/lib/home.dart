import 'package:flutter/material.dart';
import 'pages/banda_page.dart';
import 'pages/cliente_page.dart';
import 'pages/lugar_pages.dart';


class Home extends StatefulWidget{
  HomeState createState() => HomeState();
}


class HomeState extends State <Home>{

  int _selectDrawerItem =0;
    _getDraweItemWidget(int pos){
      switch(pos){
      
        case 0: return Cliente_page();
        case 1: return Banda_page();
        case 2: return Lugar_page(); 
      }
    }

    _onSelectItem(int pos){
      Navigator.of(context).pop();
      setState(() {
        _selectDrawerItem = pos;
      });
    }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Music X'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('User'),
              accountEmail: Text('User@hotmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blue,
                child:Text('U',style: TextStyle(fontSize: 40.0),),
                ),
              ),
            ListTile(
              title: Text('Cliente'),
              leading: Icon(Icons.accessibility),
              selected: (0 == _selectDrawerItem),
              onTap: (){
                _onSelectItem(0);
              },
            ),
               ListTile(
              title: Text('Banda'),
              leading: Icon(Icons.translate),
              selected: (1 == _selectDrawerItem),
              onTap: (){
                 _onSelectItem(1);
              },
            ),
               ListTile(
              title: Text('Lugar'),
              leading: Icon(Icons.place),
              selected: (2  == _selectDrawerItem),
              onTap: (){
                _onSelectItem(2);
              },
            ),
          ],
        ),
      ),
      body: _getDraweItemWidget(_selectDrawerItem),
    );
  }
}