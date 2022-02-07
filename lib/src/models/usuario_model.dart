// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    this.displayName,
    this.email,
    this.password,
  });

  String? displayName;
  String? email;
  String? password;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        displayName: json["displayName"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "email": email,
        "password": password,
      };
}
