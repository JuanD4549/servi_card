// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:servi_card/src/models/usuario_model.dart';

class UsuarioService {
  Future<UserCredential?> login(Usuario usuario) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: usuario.email!, password: usuario.password!);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  bool validToken(String token) {
    var _pedidoSn =
        FirebaseFirestore.instance.collection('pedidos').doc().snapshots();
    _pedidoSn.map((DocumentSnapshot document) {
      if (document.get("uid") == token) {
        return true;
      }
    });
    return false;
  }
}
