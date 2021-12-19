import 'package:flutter/material.dart';
import 'package:servi_card/src/models/pedido_model.dart';

class PedidoPage extends StatelessWidget {
  const PedidoPage({Key? key, required this.pedido}) : super(key: key);
  final Pedido pedido;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(appBar: AppBar(title: Text(pedido.hdr ?? ""))));
  }
}
