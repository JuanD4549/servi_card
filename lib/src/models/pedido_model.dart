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
      this.id,
      this.repartidorid,
      this.observacion,
      required this.cliente,
      required this.foto});

  String? hdr;
  String? estado;
  String? direccion;
  String? tipoServicio;
  String? id;
  String? repartidorid;
  String? observacion;
  Cliente cliente;
  Foto foto;

  factory Pedido.fromJson(Map<String, dynamic> json) => Pedido(
      direccion: json["direccion"],
      estado: json["estado"],
      hdr: json["hdr"],
      id: json["id"],
      repartidorid: json["repartidorid"],
      tipoServicio: json["tipoServicio"],
      observacion: json["observacion"],
      cliente: Cliente.fromJson(json["cliente"]),
      foto: Foto.fromJson(json["foto"]));
  Map<String, dynamic> toJson() => {
        "hdr": hdr,
        "estado": estado,
        "direccion": direccion,
        "tipoServicio": tipoServicio,
        "id": id,
        "repartidorid": repartidorid,
        "observacion": observacion,
        "cliente": cliente.toJson(),
        "foto": foto.toJson(),
      };
}
