import 'package:shared_preferences/shared_preferences.dart';

//inicializa  shared prefences por singleton
class Userpreferences {
  static final Userpreferences _instance = Userpreferences.internal();

  factory Userpreferences() {
    return _instance;
  }

  Userpreferences.internal();

  late SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

//pares clave-valor
  bool get mode {
    return _prefs.getBool('mode') ?? false;
  }

  set mode(bool value) {
    _prefs.setBool('mode', value);
  }
}
