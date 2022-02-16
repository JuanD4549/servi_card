import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servi_card/src/bloc/signup_bloc.dart';
import 'package:servi_card/src/models/repartidor_model.dart';
import 'package:servi_card/src/models/usuario_model.dart';
import 'package:servi_card/src/pages/background_login.dart';
import 'package:servi_card/src/service/usuario_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late SignUpBloc bloc;
  UsuarioService usuarioService = UsuarioService();
  bool _obscureText = true;

  @override
  void initState() {
    bloc = SignUpBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
      const Background(),
      SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: size.width * .80,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SafeArea(child: Container(height: 120.h)),
                const Padding(
                  padding: EdgeInsets.only(top: 150.0),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 14.0),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    width: size.width * .80,
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                            width: 2.0,
                            color: Theme.of(context).primaryColorDark)),
                    child: Column(
                      children: [
                        StreamBuilder(
                            stream: bloc.usernameStream,
                            builder: (BuildContext context,
                                    AsyncSnapshot snapshot) =>
                                TextField(
                                    onChanged: bloc.changeUsername,
                                    decoration: InputDecoration(
                                        errorText: snapshot.error?.toString(),
                                        icon: const Icon(Icons.person),
                                        labelText: 'Nombre'))),
                        StreamBuilder(
                            stream: bloc.emailStream,
                            builder: (BuildContext context,
                                    AsyncSnapshot snapshot) =>
                                TextField(
                                    onChanged: bloc.changeEmail,
                                    decoration: InputDecoration(
                                        errorText: snapshot.error?.toString(),
                                        icon: const Icon(Icons.email),
                                        hintText: 'usuario@trifasic.com',
                                        labelText: 'Correo electrónico'))),
                        StreamBuilder(
                            stream: bloc.cedulaStream,
                            builder: (BuildContext context,
                                    AsyncSnapshot snapshot) =>
                                TextField(
                                    keyboardType: TextInputType.number,
                                    onChanged: bloc.changeCedula,
                                    decoration: InputDecoration(
                                        errorText: snapshot.error?.toString(),
                                        icon: const Icon(
                                            Icons.assignment_ind_outlined),
                                        hintText: '1726766452',
                                        labelText: 'Cedula'))),
                        StreamBuilder(
                            stream: bloc.telefonoStream,
                            builder: (BuildContext context,
                                    AsyncSnapshot snapshot) =>
                                TextField(
                                    keyboardType: TextInputType.number,
                                    onChanged: bloc.changeTelefono,
                                    decoration: InputDecoration(
                                        errorText: snapshot.error?.toString(),
                                        icon: const Icon(
                                            Icons.phone_iphone_rounded),
                                        hintText: '0978657557',
                                        labelText: 'Telefono'))),
                        StreamBuilder(
                            stream: bloc.passwordStream,
                            builder: (BuildContext context,
                                    AsyncSnapshot snapshot) =>
                                TextField(
                                    onChanged: bloc.changePassword,
                                    obscureText: _obscureText,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            _obscureText = !_obscureText;
                                            setState(() {});
                                          },
                                          icon: _obscureText
                                              ? const Icon(Icons.visibility)
                                              : const Icon(
                                                  Icons.visibility_off)),
                                      errorText: snapshot.error?.toString(),
                                      icon: const Icon(Icons.lock_outline),
                                      labelText: 'Contraseña',
                                    ))),
                        StreamBuilder(
                            stream: bloc.signUpValidStream,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: ElevatedButton.icon(
                                    onPressed: snapshot.hasData
                                        ? () async {
                                            Usuario usuario = Usuario(
                                              displayName: bloc.username,
                                              email: bloc.email,
                                              password: bloc.password,
                                            );
                                            Repartidor rapartidor = Repartidor(
                                              cedula: bloc.cedula,
                                              nombre: bloc.username,
                                              telefono: bloc.telefono,
                                              uid: "",
                                              urlFoto: "",
                                            );

                                            bool comp = await usuarioService
                                                .registerUser(
                                                    usuario, rapartidor);
                                            if (!comp) {}
                                            Navigator.pop(context);
                                          }
                                        : null,
                                    icon: const Icon(Icons.login),
                                    label: const Text("Registrar")),
                              );
                            })
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    ])));
  }
}
