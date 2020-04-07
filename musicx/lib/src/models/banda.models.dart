// To parse this JSON data, do
//
//     final clienteModel = clienteModelFromJson(jsonString);

import 'dart:convert';

BandaModel bandaModelFromJson(String str) => BandaModel.fromJson(json.decode(str));

String bandaModelToJson(BandaModel data) => json.encode(data.toJson());

class BandaModel {
    String id;
    String nombre;
    //genero,integrantes
    String genero;
    int integrantes;
    String correo;
    int telefono;
    bool disponible;
    String fotoUrl;

    BandaModel({
        this.id,
        this.nombre ='',
        this.genero="",
        this.integrantes= 0,
        this.correo='',
        this.telefono=0,
        this.disponible = true,
        this.fotoUrl,
    });

    factory BandaModel.fromJson(Map<String, dynamic> json) => BandaModel(
        id: json["id"],
        nombre: json["nombre"],
        genero: json["genero"],
        integrantes: json["integrantes"],
        correo: json["correo"],
        telefono: json["telefono"],
        disponible: json["disponible"],
        fotoUrl: json["fotoUrl"],
    );

    Map<String, dynamic> toJson() => {
        //"id": id,
        "nombre": nombre,
        "genero":genero,
        "integrantes": integrantes,
        "correo":correo,
        "telefono":telefono,
        "disponible": disponible,
        "fotoUrl": fotoUrl,
    };
}