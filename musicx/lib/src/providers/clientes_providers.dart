import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:musicx/src/models/cliente.models.dart';

class ClientesProviders {
  final String _url = 'https://musicx-e43c0.firebaseio.com/';

  Future<bool> crearCliente(ClienteModel cliente) async {
    final url = '$_url/clientes.json';

    final resp = await http.post(url,body: clienteModelToJson(cliente) );

    final decodedData=json.decode(resp.body);

    print(decodedData);
    return true;
  }

Future<bool> editarCliente(ClienteModel cliente) async {
    final url = '$_url/clientes/${cliente.id}.json';

    final resp = await http.put(url,body: clienteModelToJson(cliente) );
  

    final decodedData=json.decode(resp.body);

    print(decodedData);
    return true;
  }


  Future <List<ClienteModel>> cargarCliente() async{
    final url='$_url/clientes.json';
    final resp=await http.get(url);

    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<ClienteModel> clientes = new List();

    if (decodeData == null )return[];
    
    decodeData.forEach((id, clien){
      final clienTemp = ClienteModel.fromJson(clien);
      clienTemp.id=id;

      clientes.add(clienTemp);
    });
    print(clientes);

    return clientes;
  }

  //BORRAR CAMPOS

  Future<int> borrarCliente(String id) async {

    final url ='$_url/clientes/$id.json';
    final resp= await http.delete(url);

    print(resp.body);

    return 1;
  }
}
