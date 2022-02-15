import 'dart:convert';

import 'package:servi_card/src/models/cliente_model.dart';
import 'package:servi_card/src/models/foto_model.dart';

Pedido pedidoFromJson(String str) => Pedido.fromJson(json.decode(str));

String pedidoToJson(Pedido data) => json.encode(data.toJson());

class Pedido {
  Pedido(
      {this.hdr,
      this.uidMotorizado,
      this.estado,
      this.direccion,
      this.tipoServicio,
      this.id,
      this.repartidorid,
      this.observacion,
      this.lat,
      this.log,
      required this.cliente,
      required this.foto});

  String? hdr;
  String? uidMotorizado;
  String? estado;
  String? direccion;
  String? tipoServicio;
  String? id;
  String? repartidorid;
  String? observacion;
  String? lat;
  String? log;
  Cliente cliente;
  Foto foto;

  factory Pedido.fromJson(Map<String, dynamic> json) => Pedido(
      direccion: json["direccion"],
      uidMotorizado: json["uidMotorizado"],
      estado: json["estado"],
      hdr: json["hdr"],
      id: json["id"],
      repartidorid: json["repartidorid"],
      tipoServicio: json["tipoServicio"],
      observacion: json["observacion"],
      lat: json["lat"],
      log: json["log"],
      cliente: Cliente.fromJson(json["cliente"]),
      foto: Foto.fromJson(json["foto"]));
  Map<String, dynamic> toJson() => {
        "hdr": hdr,
        "uidMotorizado": uidMotorizado,
        "estado": estado,
        "direccion": direccion,
        "tipoServicio": tipoServicio,
        "id": id,
        "repartidorid": repartidorid,
        "observacion": observacion,
        "lat": lat,
        "log": log,
        "cliente": cliente.toJson(),
        "foto": foto.toJson(),
      };
}
