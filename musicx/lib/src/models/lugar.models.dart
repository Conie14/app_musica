// To parse this JSON data, do
//
//     final clienteModel = clienteModelFromJson(jsonString);

import 'dart:convert';

LugarModel lugarModelFromJson(String str) => LugarModel.fromJson(json.decode(str));

String lugarModelToJson(LugarModel data) => json.encode(data.toJson());

class LugarModel {
  //Pais, estado,codigop, calle,colonia
    String id;
    String pais;
    String estado;
    int codigop;
    String calle;
    String colonia;
    bool disponible;
    String fotoUrl;

    LugarModel({
        this.id,
        this.pais ='',
        this.estado='',
        this.codigop= 0,
        this.calle='',
        this.colonia='',
        this.disponible = true,
        this.fotoUrl,
    });

    factory LugarModel.fromJson(Map<String, dynamic> json) => LugarModel(
        id: json["id"],
        pais: json["pais"],
        estado: json["estado"],
        codigop: json["codigop"],
        calle: json["calle"],
        colonia: json["colonia"],
        disponible: json["disponible"],
        fotoUrl: json["fotoUrl"],
    );

    Map<String, dynamic> toJson() => {
        //"id": id,
        "pais": pais,
        "estado":estado,
        "codigop": codigop,
        "calle":calle,
        "colonia":colonia,
        "disponible": disponible,
        "fotoUrl": fotoUrl,
    };
}