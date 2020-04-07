import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:musicx/src/models/lugar.models.dart';

class LugaresProviders {
  final String _url = 'https://musicx-e43c0.firebaseio.com/';

  Future<bool> crearLugar(LugarModel lugar) async {
    final url = '$_url/lugares.json';

    final resp = await http.post(url,body: lugarModelToJson(lugar) );

    final decodedData=json.decode(resp.body);

    print(decodedData);
    return true;
  }

Future<bool> editarLugar(LugarModel lugar) async {
    final url = '$_url/lugares/${lugar.id}.json';

    final resp = await http.put(url,body: lugarModelToJson(lugar) );
  

    final decodedData=json.decode(resp.body);

    print(decodedData);
    return true;
  }


  Future <List<LugarModel>> cargarLugar() async{
    final url='$_url/lugares.json';
    final resp=await http.get(url);

    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<LugarModel> lugares = new List();

    if (decodeData == null )return[];
    
    decodeData.forEach((id, lug){
      final lugTemp = LugarModel.fromJson(lug);
      lugTemp.id=id;

      lugares.add(lugTemp);
    });
    print(lugares);

    return lugares;
  }

  //BORRAR CAMPOS

  Future<int> borrarLugar(String id) async {

    final url ='$_url/lugares/$id.json';
    final resp= await http.delete(url);

    print(resp.body);

    return 1;
  }
}
