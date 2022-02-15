import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:servi_card/src/models/pedido_model.dart';
import 'package:servi_card/src/pages/pedido_page.dart';
import 'package:getwidget/getwidget.dart';

class PedidoCard extends StatelessWidget {
  const PedidoCard({Key? key, required this.model}) : super(key: key);
  final Pedido model;
  @override
  Widget build(BuildContext context) {
    FirebaseStorage storage = FirebaseStorage.instance;
    print(storage.bucket.characters);
    return GFCard(
      boxFit: BoxFit.cover,
      image: Image.network(
        model.foto.urlPedido!,
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width,
      ),
      showImage: true,
      title: GFListTile(
        title: Text(
          model.id! + " | HDR: " + model.hdr!,
          style: TextStyle(
              color: Colors.blue.shade300,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        subTitle: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Text(
            model.cliente.nombre!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        description: Text(
          model.direccion!,
          softWrap: true,
        ),
      ),
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
