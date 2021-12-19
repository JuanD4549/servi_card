import 'dart:convert';

Repartidor repartidorFromJson(String str) =>
    Repartidor.fromJson(json.decode(str));

String repartidorToJson(Repartidor data) => json.encode(data.toJson());

class Repartidor {
  Repartidor({
    this.nombre,
    this.cedula,
    this.telefono,
    this.idRepartidor,
  });

  String? nombre;
  String? cedula;
  String? telefono;
  String? idRepartidor;

  factory Repartidor.fromJson(Map<String, dynamic> json) => Repartidor(
        nombre: json["nombre"],
        cedula: json["cedula"],
        telefono: json["telefono"],
        idRepartidor: json["id_repartidor"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "cedula": cedula,
        "telefono": telefono,
        "id_repartidor": idRepartidor,
      };
}
