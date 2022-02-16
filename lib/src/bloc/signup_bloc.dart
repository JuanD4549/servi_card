import 'package:rxdart/rxdart.dart';
import 'package:servi_card/src/bloc/validators_bloc.dart';

class SignUpBloc with Validator {
  SignUpBloc();

  final _usernameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _cedulaController = BehaviorSubject<String>();
  final _telefonoController = BehaviorSubject<String>();

  Stream<String> get usernameStream =>
      _usernameController.stream.transform(usernameValidator);
  Stream<String> get emailStream =>
      _emailController.stream.transform(emailValidator);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(passwordValidator);
  Stream<String> get cedulaStream =>
      _cedulaController.stream.transform(cedulaValidator);
  Stream<String> get telefonoStream =>
      _telefonoController.stream.transform(telefonoValidator);

  Stream<bool> get signUpValidStream => Rx.combineLatest5(
      usernameStream,
      emailStream,
      passwordStream,
      cedulaStream,
      telefonoStream,
      (a, b, c, d, e) => true);

  Function(String) get changeUsername => _usernameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeCedula => _cedulaController.sink.add;
  Function(String) get changeTelefono => _telefonoController.sink.add;

  String get username => _usernameController.value;
  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get cedula => _cedulaController.value;
  String get telefono => _telefonoController.value;
  dispose() {
    _usernameController.close();
    _emailController.close();
    _passwordController.close();
    _cedulaController.close();
    _telefonoController.close();
  }
}
