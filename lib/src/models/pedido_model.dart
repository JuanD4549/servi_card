import 'dart:convert';

Pedido pedidoFromJson(String str) => Pedido.fromJson(json.decode(str));

String pedidoToJson(Pedido data) => json.encode(data.toJson());

class Pedido {
  Pedido(
      {this.hdr,
      this.estado,
      this.direccion,
      this.tipoServicio,
      this.idPedido,
      this.repartidor,
      this.cliente,
      this.foto});

  String? hdr;
  String? estado;
  String? direccion;
  String? tipoServicio;
  String? idPedido;
  String? cliente;
  String? foto;
  String? repartidor;

  factory Pedido.fromJson(Map<String, dynamic> json) => Pedido(
      cliente: json["cliente"],
      direccion: json["direccion"],
      estado: json["estado"],
      foto: json["foto"],
      hdr: json["hdr"],
      idPedido: json["idPedido"],
      repartidor: json["repartidor"],
      tipoServicio: json["tipoServicio"]);
  Map<String, dynamic> toJson() => {
        "hdr": hdr,
        "estado": estado,
        "direccion": direccion,
        "tipoServicio": tipoServicio,
        "idPedido": idPedido,
        "repartidor": repartidor,
        "cliente": cliente,
        "foto": foto
      };
}
