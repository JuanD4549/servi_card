import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servi_card/src/models/pedido_model.dart';
import 'package:firebase_core/firebase_core.dart';

class PedidoService {
  PedidoService();

  Future<List<Pedido>> getPedido() async {
    await Firebase.initializeApp();
    List<Pedido> _pedidos = [];
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("pedido");
      QuerySnapshot pedido = await collectionReference.get();
      if (pedido.docs.isNotEmpty) {
        pedido.docs.map((DocumentSnapshot document) {
          Pedido model =
              Pedido.fromJson(document.data() as Map<String, dynamic>);
          _pedidos.add(model);
        });
        return _pedidos;
      }
    } catch (exp) {
      // ignore: avoid_print
      print(exp);
    }
    return _pedidos;
  }
}
