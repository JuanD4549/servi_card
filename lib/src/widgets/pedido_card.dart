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
      image: Image.asset(
        "assets/img/imgTest.gif",
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      showImage: true,
      title: GFListTile(
        avatar: const GFAvatar(
          backgroundImage: AssetImage('assets/img/3.png'),
        ),
        title: Text(model.id! + " | " + model.hdr!),
        subTitle: Text(model.cliente!.nombre!),
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
