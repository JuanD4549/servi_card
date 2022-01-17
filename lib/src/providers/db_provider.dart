import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:servi_card/src/models/pedido_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider dbProvider = DBProvider._();

  DBProvider._();

  get database async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

  Future<Database> initDb() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    final path = join(appDir.path, 'Servicard.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE Pedido(
            id INTEGER PRIMARY KEY,
            nombre TEXT,
            descripcion TEXT)''');
    });
  }

  Future<int> insert(Pedido newPedido) async {
    final Database? db = await database;
    final newId = await db!.insert('Pedido', newPedido.toJson());
    return newId;
  }

  Future<List<Pedido>> list() async {
    final Database? db = await database;
    final result = await db!.query('Pedido');
    return result.isNotEmpty
        ? result.map((e) => Pedido.fromJson(e)).toList()
        : [];
  }
}
