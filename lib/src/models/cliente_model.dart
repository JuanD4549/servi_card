import 'dart:convert';

Cliente clienteFromJson(String str) => Cliente.fromJson(json.decode(str));

class Cliente {
  Cliente({
    this.nombre,
    this.cedula,
    this.telefono,
    this.urlFoto,
  });

  String? nombre;
  String? cedula;
  String? telefono;
  String? urlFoto;

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        nombre: json["nombre"],
        cedula: json["cedula"],
        telefono: json["telefono"],
        urlFoto: json["urlFoto"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "cedula": cedula,
        "telefono": telefono,
        "urlFoto": urlFoto,
      };
}
