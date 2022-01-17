import 'package:flutter/cupertino.dart';
import 'package:servi_card/src/models/pedido_model.dart';
import 'package:servi_card/src/providers/db_provider.dart';

class PedidoProvider extends ChangeNotifier {
  List<Pedido> elements = [];
  Future<Pedido> addElement(Pedido model) async {
    final id = await DBProvider.dbProvider.insert(model);
    model.id = id.toString();
    elements.add(model);
    notifyListeners();
    return model;
  }

  Future<List<Pedido>> loadElements() async {
    elements = await DBProvider.dbProvider.list();
    return elements;
  }
}
