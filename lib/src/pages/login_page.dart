import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:servi_card/src/bloc/login_bloc.dart';
import 'package:servi_card/src/models/usuario_model.dart';
import 'package:servi_card/src/pages/background_login.dart';
import 'package:servi_card/src/providers/main_provider.dart';
import 'package:servi_card/src/service/usuario_service.dart';
import 'dart:developer' as developer;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc bloc;
  UsuarioService usuarioService = UsuarioService();
  bool _obscureText = true;

  @override
  void initState() {
    bloc = LoginBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mainProvider = Provider.of<MainProvider>(context);
    return Stack(children: [
      const Background(),
      SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
          body: SingleChildScrollView(
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
                                stream: bloc.emailStream,
                                builder: (BuildContext context,
                                        AsyncSnapshot snapshot) =>
                                    TextField(
                                        onChanged: bloc.changeEmail,
                                        decoration: InputDecoration(
                                            errorText:
                                                snapshot.error?.toString(),
                                            icon: const Icon(Icons.email),
                                            hintText: 'usuario@trifasic.com',
                                            labelText: 'Correo electrónico'))),
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
                                stream: bloc.loginValidStream,
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0),
                                    child: ElevatedButton.icon(
                                        onPressed: snapshot.hasData
                                            ? () async {
                                                Usuario usuario = Usuario(
                                                    email: bloc.email,
                                                    password: bloc.password);
                                                UserCredential? resp =
                                                    await usuarioService
                                                        .login(usuario);
                                                String token =
                                                    (resp!.user!.uid);
                                                if (token != "") {
                                                  developer.log(token);
                                                  mainProvider.token = token;
                                                }
                                              }
                                            : null,
                                        icon: const Icon(Icons.login),
                                        label: const Text("Ingresar")),
                                  );
                                })
                          ],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "¿No tiene una cuenta?",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/singUp");
                            },
                            child: const Text("Registrarse")),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
