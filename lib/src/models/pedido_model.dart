import 'dart:convert';

import 'package:servi_card/src/models/cliente_model.dart';
import 'package:servi_card/src/models/foto_model.dart';

Pedido pedidoFromJson(String str) => Pedido.fromJson(json.decode(str));

String pedidoToJson(Pedido data) => json.encode(data.toJson());

class Pedido {
  Pedido(
      {this.hdr,
      this.estado,
      this.direccion,
      this.tipoServicio,
      required this.idPedido,
      this.cliente,
      this.foto});

  String? hdr;
  int? estado;
  String? direccion;
  String? tipoServicio;
  String idPedido;
  Cliente? cliente;
  Foto? foto;

  factory Pedido.fromJson(Map<String, dynamic> json) => Pedido(
      hdr: json["hdr"],
      estado: json["estado"],
      direccion: json["direccion"],
      tipoServicio: json["tipoServicio"],
      idPedido: json["idPedido"],
      cliente: Cliente.fromJson(json["cliente"]),
      foto: Foto.fromJson(json["foto"]));
  Map<String, dynamic> toJson() => {
        "hdr": hdr,
        "estado": estado,
        "direccion": direccion,
        "tipoServicio": tipoServicio,
        "idPedido": idPedido,
        "cliente": cliente!.toJson(),
        "foto": foto!.toJson()
      };
}
