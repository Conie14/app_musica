import 'dart:convert';
//import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:musicx/src/models/banda.models.dart';
import 'dart:io';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';


class BandasProviders {
  final String _url = 'https://musicx-e43c0.firebaseio.com/';

  Future<bool> crearBanda(BandaModel banda) async {
    final url = '$_url/bandas.json';

    final resp = await http.post(url,body: bandaModelToJson(banda) );

    final decodedData=json.decode(resp.body);

    print(decodedData);
    return true;
  }

Future<bool> editarBanda(BandaModel banda) async {
    final url = '$_url/bandas/${banda.id}.json';

    final resp = await http.put(url,body: bandaModelToJson(banda) );
  

    final decodedData=json.decode(resp.body);

    print(decodedData);
    return true;
  }


  Future <List<BandaModel>> cargarBanda() async{
    final url='$_url/bandas.json';
    final resp=await http.get(url);

    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<BandaModel> bandas = new List();

    if (decodeData == null )return[];
    
    decodeData.forEach((id, clien){
      final banTemp = BandaModel.fromJson(clien);
      banTemp.id=id;

      bandas.add(banTemp);
    });
    print(bandas);

    return bandas;
  }

  //BORRAR CAMPOS

  Future<int> borrarBanda(String id) async {

    final url ='$_url/bandas/$id.json';
    final resp= await http.delete(url);

    print(resp.body);

    return 1;
  }
  Future<String> subirImagen(File imagen) async {

    final url = Uri.parse('https://api.cloudinary.com/v1_1/daqgpun9g/image/upload?upload_preset=fmz1rkun');
   final mimeType = mime(imagen.path).split('/');

   final imageUploadRequest = http.MultipartRequest(
     'POST',
     url
   );

   final file = await http.MultipartFile.fromPath(
     'file', 
     imagen.path,
     contentType: MediaType( mimeType[0], mimeType[1])
     );

     imageUploadRequest.files.add(file);

     final streamResponse = await imageUploadRequest.send();
     final resp = await http.Response.fromStream(streamResponse);
     if(resp.statusCode != 200 && resp.statusCode != 201){
       print('Algo salio mal');
       print(resp.body);
       return null;
     }
     final respData = json.decode(resp.body);
     print(respData);
     return respData['secure_url'];
  }

}
