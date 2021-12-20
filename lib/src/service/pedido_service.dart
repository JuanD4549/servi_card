import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servi_card/src/models/pedido_model.dart';

class PedidoService {
  PedidoService();

  Future<List?> getPedido() async {
    List pedidos = [];
    Pedido _p;
    _p.hdr = "1";

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("pedido");
    QuerySnapshot pedido = await collectionReference.get();
    if (pedido.docs.isNotEmpty) {
      for (var doc in pedido.docs) {
        _p.hdr = doc.data(['hdr']);
      }
    }
    return pedidos;
  }
}
