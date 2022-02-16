import 'dart:async';

class Validator {
  final emailValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      String pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern);
      if (regExp.hasMatch(data)) {
        sink.add(data);
      } else {
        sink.addError('El correo electrónico no es válido');
      }
    },
  );

  final passwordValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.length > 5) {
        sink.add(data);
      } else {
        sink.addError('La contraseña debe tener al menos 6 caracteres');
      }
    },
  );
  final telefonoValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      String pattern = r'(^[0-9]*$)';
      RegExp regExp = RegExp(pattern);
      if (regExp.hasMatch(data)) {
        if (data.length == 10) {
          sink.add(data);
        }
      } else {
        sink.addError('El telefono no es válido');
      }
    },
  );
  final cedulaValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      String pattern = r'(^[0-9]*$)';
      RegExp regExp = RegExp(pattern);
      if (regExp.hasMatch(data)) {
        if (data.length == 10) {
          sink.add(data);
        }
      } else {
        sink.addError('La cedula no es valida no es válido');
      }
    },
  );
  final usernameValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.isNotEmpty) {
        sink.add(data);
      } else {
        sink.addError('Ingrese un nombre');
      }
    },
  );
}
