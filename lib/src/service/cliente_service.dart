import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servi_card/src/models/cliente_model.dart';
import 'package:firebase_core/firebase_core.dart';

class ClienteService {
  ClienteService();

  Future<Cliente> getCliente(String clienteid) async {
    await Firebase.initializeApp();
    Cliente _c = Cliente();
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("cliente");
      QuerySnapshot cliente = await collectionReference.get();
      if (cliente.docs.isNotEmpty) {
        for (var doc in cliente.docs) {
          if (clienteid == doc.id) {
            _c = Cliente(
                cedula: doc.get("cedula").toString(),
                nombre: doc.get("nombre").toString(),
                telefono: doc.get("telefono").toString());
            return _c;
          }
        }
      }
    } catch (exp) {
      // ignore: avoid_print
      print(exp);
    }
    return _c;
  }
}
