import 'dart:async';
import 'dart:developer' as developer;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servi_card/src/providers/main_provider.dart';
import 'package:servi_card/src/service/usuario_service.dart';
import 'package:servi_card/src/utils/home_menu.dart';
import 'package:provider/provider.dart';
import 'package:servi_card/src/widgets/conection_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        endDrawer: const Drawer(),
        body: _connectionStatus == ConnectivityResult.none
            ? ConectionWidget(
                titulo: ItemMenu(Icons.cloud_off, "No hay internet"),
                descripcion: "Verifique la conexión")
            : getBody(),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            mainProvider.index = index;
          },
          type: BottomNavigationBarType.fixed,
          items: menuOptions
              .map((e) =>
                  BottomNavigationBarItem(icon: Icon(e.icon), label: e.title))
              .toList(),
          currentIndex: mainProvider.index,
        ),
      ),
    );
  }

  Widget getBody() {
    UsuarioService usuario = UsuarioService();
    var size = MediaQuery.of(context).size;
    final mainProvider = Provider.of<MainProvider>(context, listen: true);
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 15),
          child: Container(
            width: size.width,
            height: 55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 0))
                ]),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: FloatingActionButton(
                    onPressed: () async {
                      await usuario.logOutuser();
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/login");
                    },
                    child: Image.asset("assets/img/icono2.png"),
                  ),
                ),
                SizedBox(
                    child: RawMaterialButton(
                  onPressed: () async {
                    await _sendToServer(mainProvider.token);
                  },
                  child: Text(
                    'ServiCard',
                    style: TextStyle(
                        color: Colors.blueAccent.shade200,
                        fontSize: 19,
                        fontWeight: FontWeight.w400),
                  ),
                )),
                SizedBox(
                    child: Switch(
                        value: mainProvider.mode,
                        onChanged: (bool value) async {
                          mainProvider.mode = value;
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool("mode", value);
                        }))
              ],
            ),
          ),
        ),
        Expanded(child: homeWidgets[mainProvider.index])
      ],
    );
  }

  Future<void> _sendToServer(String token) async {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('pedido');
      reference.add({
        "uidMotorizado": token,
        "hdr": "145662",
        "estado": "0",
        "lat": "-0.302233",
        "log": "-78.477742",
        "direccion": "Calle Juan Montalvo",
        "tipoServicio": "normal",
        "id": "MV" + Random().nextInt(1000).toString(),
        "repartidorid": "lffTkTbfoZEKWVn4uQyJ",
        "observacion": "",
        "cliente": {
          "cedula": "1726766452",
          "nombre": "Movistar" + Random().nextInt(1000).toString(),
          "telefono": "0978657557",
          "urlFoto": "",
        },
        "foto": {
          "urlDocumento": "",
          "urlPedido":
              "https://th.bing.com/th/id/R.ab4190e35eecd8aa920fb72996fd2acb?rik=GNrZgMM%2fc3Kadg&riu=http%3a%2f%2fwww.pcactual.com%2fmedio%2f2012%2f11%2f27%2ffirma_digital_apertura_618x437.jpg&ehk=9oaUQiJ%2fGGfL1KzmoKE3RXCLNdQbmbyAAqKcZMDdvFI%3d&risl=&pid=ImgRaw&r=0"
        },
      });
    });
  }
}
