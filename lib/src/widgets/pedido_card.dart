import 'package:flutter/material.dart';
import 'package:servi_card/src/models/pedido_model.dart';
import 'package:servi_card/src/pages/pedido_page.dart';
import 'package:firebase_core/firebase_core.dart';

class PedidoCard extends StatelessWidget {
  const PedidoCard({Key? key, required this.model}) : super(key: key);
  final Pedido model;

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Card(
        child: ListTile(
      onTap: () {
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext context) => PedidoPage(
                    pedido: model,
                  )),
        );
      },
      title: Text(model.idPedido! + "|" + model.hdr!),
      subtitle: Text(model.estado!.toString()),
    ));
  }
}
