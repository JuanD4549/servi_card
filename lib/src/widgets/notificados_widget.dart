import 'package:flutter/material.dart';
import 'package:servi_card/src/widgets/pedido_card.dart';

class NotificadoWidget extends StatefulWidget {
  const NotificadoWidget({Key? key}) : super(key: key);

  @override
  State<NotificadoWidget> createState() => _NotificadoWidgetState();
}

class _NotificadoWidgetState extends State<NotificadoWidget> {
  //final PedidoService _PedidoService = PedidoService();
  List? _listaPedidos;

  @override
  void initState() {
    super.initState();
    //_downloadMantenimientos();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 4.0),
      child: _listaPedidos == null
          ? const Center(
              child: SizedBox.square(
                  dimension: 50.0, child: CircularProgressIndicator()),
            )
          : _listaPedidos!.isEmpty
              ? const Center(child: Text("No hay mantenimientos registrados"))
              : ListView(
                  children:
                      _listaPedidos!.map((e) => PedidoCard(model: e)).toList(),
                ),
    );
  }

  /*_downloadMantenimientos() async {
    _listaPedidos = await _PedidoService.getPedido();
  }*/
}
