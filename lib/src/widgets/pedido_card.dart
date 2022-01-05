import 'package:flutter/material.dart';
import 'package:servi_card/src/models/pedido_model.dart';
import 'package:servi_card/src/pages/pedido_page.dart';
import 'package:getwidget/getwidget.dart';

class PedidoCard extends StatelessWidget {
  const PedidoCard({Key? key, required this.model}) : super(key: key);
  final Pedido model;
  @override
  Widget build(BuildContext context) {
    return GFCard(
      boxFit: BoxFit.cover,
      image: Image.network(
        model.foto!.url!,
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width,
      ),
      showImage: true,
      title: GFListTile(
        title: Text(
          model.id! + " | " + model.hdr!,
          style: TextStyle(
              color: Colors.blue.shade300,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        subTitle: Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Text(
            model.cliente!.nombre!,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      content: Text(model.direccion!),
      buttonBar: GFButtonBar(
        children: <Widget>[
          GFButton(
            onPressed: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => PedidoPage(
                    pedido: model,
                  ),
                ),
              );
            },
            text: 'Detalles',
          ),
        ],
      ),
    );
  }
}
