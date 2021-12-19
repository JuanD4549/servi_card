import 'package:flutter/material.dart';
import 'package:servi_card/src/widgets/pendientes_widget.dart';

class ItemMenu {
  String title;
  IconData icon;
  ItemMenu(this.icon, this.title);
}

List<ItemMenu> menuOptions = [
  ItemMenu(Icons.home, "Inicio"),
  ItemMenu(Icons.build, "Mantenimientos"),
  ItemMenu(Icons.cable, "Materiales"),
];

List<Widget> homeWidgets = [
  const PendientesWidget(),
];
