import 'package:flutter/material.dart';
import 'package:servi_card/src/widgets/confirmados_widget.dart';
import 'package:servi_card/src/widgets/notificados_widget.dart';
import 'package:servi_card/src/widgets/pendientes_widget.dart';

class ItemMenu {
  String title;
  IconData icon;
  ItemMenu(this.icon, this.title);
}

List<ItemMenu> menuOptions = [
  ItemMenu(Icons.home, "Pendientes"),
  ItemMenu(Icons.build, "Confirmados"),
  ItemMenu(Icons.cable, "Notificados"),
];

List<Widget> homeWidgets = [
  const PendientesWidget(),
  const ConfirmadoWidget(),
  const NotificadoWidget()
];
