import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servi_card/src/models/pedido_model.dart';
import 'package:servi_card/src/providers/main_provider.dart';
import 'package:servi_card/src/widgets/pedido_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PedidosWidget extends StatefulWidget {
  const PedidosWidget({Key? key, required this.estado}) : super(key: key);
  final String estado;
  @override
  State<PedidosWidget> createState() => _PedidosWidgetState();
}

class _PedidosWidgetState extends State<PedidosWidget> {
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: true);
    final Stream<QuerySnapshot> _pedidoStrem = FirebaseFirestore.instance
        .collection('pedido')
        .where("uidMotorizado", isEqualTo: mainProvider.token)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: _pedidoStrem,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            const Center(
              child: Center(child: Text("Error al consultar los pedidos")),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: CircularProgressIndicator()),
            );
          }
          return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Pedido model =
                Pedido.fromJson(document.data() as Map<String, dynamic>);
            if (model.estado == widget.estado) {
              return PedidoCard(model: model);
            }
            return const Text("");
          }).toList());
        });
  }
}
