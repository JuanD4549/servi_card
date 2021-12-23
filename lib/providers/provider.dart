import 'package:flutter/foundation.dart';

class MyProvider with ChangeNotifier {
  String _mitexto =
      "Servi Card"; //Dentro de nuestro provider, creamos e inicializamos nuestra variable.
  String get mitexto =>
      _mitexto; //Creamos el método Get, para poder obtener el valor de mitexto
//Ahora creamos el método set para poder actualizar el valor de _mitexto, este método recibe un valor newTexto de tipo String
  set mitexto(String newTexto) {
    _mitexto = newTexto; //actualizamos el valor
    notifyListeners(); //notificamos a los widgets que esten escuchando el stream.
  }
}
