import 'dart:convert';

Cliente clienteFromJson(String str) => Cliente.fromJson(json.decode(str));

class Cliente {
  Cliente({
    this.nombre,
    this.cedula,
    this.telefono,
  });

  String? nombre;
  String? cedula;
  String? telefono;

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        nombre: json["nombre"],
        cedula: json["cedula"],
        telefono: json["telefono"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "cedula": cedula,
        "telefono": telefono,
      };
}
