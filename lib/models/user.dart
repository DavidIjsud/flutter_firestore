// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    Usuario({
        this.ci,
        this.nombreCompleto,
        this.apellidoCompleto
    });

    String ci;
    String nombreCompleto;
    String apellidoCompleto;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        ci: json["ci"],
        nombreCompleto: json["nombre_completo"],
        apellidoCompleto: json["apellido_completo"]
    );

    Map<String, dynamic> toJson() => {
        "ci": ci,
        "nombre_completo": nombreCompleto,
        "apellido_completo": apellidoCompleto,
    };
}
