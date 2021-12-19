import 'package:flutter/material.dart';
import 'package:servi_card/src/providers/main_provider.dart';

final List<String> _options = ["Pendientes", "Confirmados", "Notificados"];

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        endDrawer: const Drawer(),
        appBar: AppBar(
            leading: Switch(
                value: mainProvider.mode,
                onChanged: (bool value) async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool("mode", value);
                  mainProvider.mode = value;
                }),
            centerTitle: true,
            title: Text('Trifasic - ' + _options[mainProvider.index])),
        body: homeWidgets[mainProvider.index],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            mainProvider.index = index;
          },
          currentIndex: mainProvider.index,
          type: BottomNavigationBarType.fixed,
          items: menuOptions
              .map((e) =>
                  BottomNavigationBarItem(icon: Icon(e.icon), label: e.title))
              .toList(),
        ),
      ),
    );
  }
}
