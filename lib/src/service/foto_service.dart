import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servi_card/src/models/foto_model.dart';
import 'package:firebase_core/firebase_core.dart';

class FotoService {
  FotoService();

  Future<Foto> getFoto(String fotoid) async {
    Foto _f = Foto();
    await Firebase.initializeApp();
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("foto");
      QuerySnapshot foto = await collectionReference.get();
      if (foto.docs.isNotEmpty) {
        for (var doc in foto.docs) {
          if (fotoid == doc.id) {
            _f = Foto(urlPedido: doc.get("url").toString());
            return _f;
          }
        }
      }
    } catch (exp) {
      // ignore: avoid_print
      print(exp);
    }
    return _f;
  }
}
