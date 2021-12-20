import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servi_card/src/models/pedido_model.dart';
import 'package:firebase_core/firebase_core.dart';

class PedidoService {
  PedidoService();

  Future<List<Pedido>> getPedido() async {
    await Firebase.initializeApp();
    List<Pedido> pedidos = [];
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("pedido");
      QuerySnapshot pedido = await collectionReference.get();
      if (pedido.docs.isNotEmpty) {
        for (var doc in pedido.docs) {
          Pedido p = Pedido(
              cliente: doc.get("cliente").toString(),
              direccion: doc.get("direccion").toString(),
              estado: doc.get("estado").toString(),
              foto: doc.get("foto").toString(),
              hdr: doc.get("hdr").toString(),
              idPedido: doc.get("idPedido").toString(),
              repartidor: doc.get("repartidor").toString(),
              tipoServicio: doc.get("tipoServicio").toString());

          pedidos.add(p);
        }
        return pedidos;
      }
    } catch (exp) {
      // ignore: avoid_print
      print(exp);
    }
    return pedidos;
  }
}
