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
          'https://riacomptech.com/wp-content/uploads/2018/04/delivery.blue_.png'),
      title: GFListTile(
        title: Text(model.idPedido! + "|" + model.idPedido!),
        subTitle: Text(model.cliente!),
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
                        )),
              );
            },
            text: 'Detalles',
          )
        ],
      ),
    );
  }
}
