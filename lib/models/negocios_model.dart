// To parse this JSON data, do
//
//     final getDataModelNegocios = getDataModelNegociosFromJson(jsonString);

import 'dart:convert';

GetDataModelNegocios getDataModelNegociosFromJson(String str) => GetDataModelNegocios.fromJson(json.decode(str));

String getDataModelNegociosToJson(GetDataModelNegocios data) => json.encode(data.toJson());

class GetDataModelNegocios {
    List<Negocios> negocios;

    GetDataModelNegocios({
        required this.negocios,
    });

    factory GetDataModelNegocios.fromJson(Map<String, dynamic> json) => GetDataModelNegocios(
        negocios: List<Negocios>.from(json["Negocios"].map((x) => Negocios.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Negocios": List<dynamic>.from(negocios.map((x) => x.toJson())),
    };
}

class Negocios {
    String idUsuario;
    String idCategoria;
    String nombreComercial;
    String? telefono;
    String? direccion;
    String? colonia;
    String? municipio;
    String? codigoPostal;
    String? estado;
    String? redesSociales;
    String comentarios;
    String? linkDireccion;

    Negocios({
        required this.idUsuario,
        required this.idCategoria,
        required this.nombreComercial,
        required this.telefono,
        required this.direccion,
        required this.colonia,
        required this.municipio,
        required this.codigoPostal,
        required this.estado,
        required this.redesSociales,
        required this.comentarios,
        required this.linkDireccion,
    });

    factory Negocios.fromJson(Map<String, dynamic> json) {

      // si json["linkDireccion"] es null entonces linkDireccion = 'No cuenta con link'
      if(json["linkDireccion"] == null){
        json["linkDireccion"] = 'No cuenta con link';
      }
      // si json["redesSociales"] no contiene un http entonces redesSociales = 'No cuenta con redes sociales'
      if(!json["redesSociales"].contains('http')){
        json["redesSociales"] = 'No cuenta con redes sociales';
      }

      if(json["redesSociales"] == null){
        json["redesSociales"] = 'No cuenta con redes sociales';
      }

      // retornamos los datos del json
      return Negocios(
        idUsuario: json["idUsuario"].toString(),
        idCategoria: json["idCategoria"].toString(),
        nombreComercial: json["nombreComercial"].toString(),
        telefono: json["telefono"].toString(),
        direccion: json["direccion"].toString(),
        colonia: json["colonia"].toString(),
        municipio: json["municipio"].toString(),
        codigoPostal: json["codigoPostal"].toString(),
        estado: json["estado"].toString(),
        redesSociales: json["redesSociales"].toString(),
        comentarios: json["comentarios"].toString(),
        linkDireccion: json["linkDireccion"].toString(),
      );
    } 

    Map<String, dynamic> toJson() => {
        "idUsuario": idUsuario,
        "idCategoria": idCategoria,
        "nombreComercial": nombreComercial,
        "telefono": telefono,
        "direccion": direccion,
        "colonia": colonia,
        "municipio": municipio,
        "codigoPostal": codigoPostal,
        "estado": estado,
        "redesSociales": redesSociales,
        "comentarios": comentarios,
        "linkDireccion": linkDireccion,
    };
}