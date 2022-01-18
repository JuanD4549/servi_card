import 'dart:convert';

Foto fotoFromJson(String str) => Foto.fromJson(json.decode(str));

String fotoToJson(Foto data) => json.encode(data.toJson());

class Foto {
  Foto({this.urlPedido, this.urlDocumento});

  String? urlPedido;
  String? urlDocumento;

  factory Foto.fromJson(Map<String, dynamic> json) =>
      Foto(urlPedido: json["urlPedido"], urlDocumento: json["urlDocumento"]);

  Map<String, dynamic> toJson() =>
      {"urlPedido": urlPedido, "urlDocumento": urlDocumento};
}
