import 'dart:convert';

Repartidor repartidorFromJson(String str) =>
    Repartidor.fromJson(json.decode(str));

String repartidorToJson(Repartidor data) => json.encode(data.toJson());

class Repartidor {
  Repartidor({
    this.nombre,
    this.cedula,
    this.telefono,
    this.uid,
    this.urlFoto,
  });

  String? nombre;
  String? cedula;
  String? telefono;
  String? uid;
  String? urlFoto;

  factory Repartidor.fromJson(Map<String, dynamic> json) => Repartidor(
        nombre: json["nombre"],
        cedula: json["cedula"],
        telefono: json["telefono"],
        uid: json["uid"],
        urlFoto: json["urlFoto"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "cedula": cedula,
        "telefono": telefono,
        "uid": uid,
        "urlFot": urlFoto,
      };
}
