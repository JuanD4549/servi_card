import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import 'package:servi_card/src/models/usuario_model.dart';

class UsuarioService {
  final String _firebaseAPIKey = 'AIzaSyCAMKL5s7BmlpsWEBsjyp-oJTKXl0MMB9c';

  Future<Map<String, dynamic>> login(Usuario usuario) async {
    final authData = {
      'email': usuario.email,
      'password': usuario.password,
      'returnSecureToken': true
    };

    final queryParams = {"key": _firebaseAPIKey};

    var uri = Uri.https("www.googleapis.com",
        "/identitytoolkit/v3/relyingparty/verifyPassword", queryParams);

    final resp = await http.post(uri, body: json.encode(authData));

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    developer.log(decodedResp.toString());
    return decodedResp;
  }
}
