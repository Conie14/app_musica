// To parse this JSON data, do
//
//     final clienteModel = clienteModelFromJson(jsonString);

import 'dart:convert';

ClienteModel clienteModelFromJson(String str) => ClienteModel.fromJson(json.decode(str));

String clienteModelToJson(ClienteModel data) => json.encode(data.toJson());

class ClienteModel {
    String id;
    String nombre;
    String apellido;
    int edad;
    String correo;
    int telefono;
    bool disponible;
    String fotoUrl;

    ClienteModel({
        this.id,
        this.nombre ='',
        this.apellido,
        this.edad= 0,
        this.correo='',
        this.telefono=0,
        this.disponible = true,
        this.fotoUrl,
    });

    factory ClienteModel.fromJson(Map<String, dynamic> json) => ClienteModel(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        edad: json["edad"],
        correo: json["correo"],
        telefono: json["telefono"],
        disponible: json["disponible"],
        fotoUrl: json["fotoUrl"],
    );

    Map<String, dynamic> toJson() => {
        //"id": id,
        "nombre": nombre,
        "apellido":apellido,
        "edad": edad,
        "correo":correo,
        "telefono":telefono,
        "disponible": disponible,
        "fotoUrl": fotoUrl,
    };
}