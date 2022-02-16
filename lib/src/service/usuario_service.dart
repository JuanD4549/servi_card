// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:servi_card/src/models/repartidor_model.dart';

import 'package:servi_card/src/models/usuario_model.dart';

class UsuarioService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<UserCredential?> login(Usuario usuario) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: usuario.email!, password: usuario.password!);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Contraseñana incorrecta.');
      } else if (e.code == 'email-already-in-use') {
        print('email incorrecto');
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

  logOutuser() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<bool> registerUser(Usuario usuario, Repartidor repartidor) async {
    try {
      final User? user = (await _auth.createUserWithEmailAndPassword(
        email: usuario.email!,
        password: usuario.password!,
      ))
          .user;
      repartidor.uid = user!.uid;
      createDateUser(repartidor);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> createDateUser(Repartidor usuario) async {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference;
      reference = FirebaseFirestore.instance.collection("repartidor");
      await reference.add(usuario.toJson());
    });
  }
}
