import 'dart:async';
import 'dart:developer' as developer;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servi_card/src/providers/main_provider.dart';
import 'package:servi_card/src/utils/home_menu.dart';
import 'package:provider/provider.dart';
import 'package:servi_card/src/widgets/conection_widget.dart';

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
                    width: 50,
                    child: RawMaterialButton(
                        onPressed: () {}, child: const Icon(Icons.menu))),
                SizedBox(
                    width: 270,
                    child: RawMaterialButton(
                      onPressed: () {},
                      child: const Text(
                        'ServiCard',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w400),
                      ),
                    )),
                SizedBox(
                  width: 40,
                  child: RawMaterialButton(
                    onPressed: () {},
                    child: const CircleAvatar(),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(child: homeWidgets[mainProvider.index])
      ],
    );
  }
}
