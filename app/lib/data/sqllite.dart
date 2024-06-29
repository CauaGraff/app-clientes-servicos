import 'dart:io';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SqliteConnection {
  Future<sql.Database> db() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    return sql.openDatabase(
      'D:\\UNC_ENG_SW_2022\\5 fase\\4 Desenvolvimento Mobile\\Trabalho\\dataservicos.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database, version);
      },
    );
  }

  Future<void> createTables(sql.Database database, int version) async {
    await database.execute("""CREATE TABLE clientes(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nome TEXT,
        telefone TEXT,
        email TEXT,
        endereco TEXT
      )
      """);
  }
}
