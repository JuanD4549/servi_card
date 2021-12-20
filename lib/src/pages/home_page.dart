import 'package:flutter/material.dart';
import 'package:servi_card/src/utils/home_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: const Drawer(),
        body: homeWidgets[0],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {},
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
