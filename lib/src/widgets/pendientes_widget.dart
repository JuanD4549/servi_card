import 'package:flutter/material.dart';
import 'package:servi_card/src/models/pedido_model.dart';
import 'package:servi_card/src/widgets/pedido_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PendientesWidget extends StatefulWidget {
  const PendientesWidget({Key? key}) : super(key: key);

  @override
  State<PendientesWidget> createState() => _PendientesWidgetState();
}

class _PendientesWidgetState extends State<PendientesWidget> {
  final Stream<QuerySnapshot> _pedidoStrem =
      FirebaseFirestore.instance.collection('pedido').snapshots();
  @override
  Widget build(BuildContext context) {
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
            return PedidoCard(model: model);
          }).toList());
        });
  }
}
