import 'package:flutter/material.dart';
import 'package:servi_card/src/widgets/pedidos_widget.dart';

class ItemMenu {
  String title;
  IconData icon;
  ItemMenu(this.icon, this.title);
}

List<ItemMenu> menuOptions = [
  ItemMenu(Icons.shopping_cart_sharp, "Pendientes"),
  ItemMenu(Icons.check_circle_outline_rounded, "Confirmados"),
  ItemMenu(Icons.chat_rounded, "Notificados"),
];

List<Widget> homeWidgets = [
  const PedidosWidget(
    estado: "0",
  ),
  const PedidosWidget(
    estado: "1",
  ),
  const PedidosWidget(
    estado: "0.5",
  )
];
