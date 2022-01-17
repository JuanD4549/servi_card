import 'package:flutter/material.dart';
import 'package:servi_card/src/utils/home_menu.dart';

class ConectionWidget extends StatelessWidget {
  const ConectionWidget(
      {Key? key, required this.titulo, required this.descripcion})
      : super(key: key);
  final ItemMenu titulo;
  final String descripcion;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          margin: const EdgeInsets.all(7.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(titulo.icon, size: 50.0),
              Text(titulo.title, style: Theme.of(context).textTheme.headline6),
              Container(
                margin: const EdgeInsets.all(20.0),
                child: Text(descripcion,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2),
              ),
            ],
          )),
    );
  }
}
