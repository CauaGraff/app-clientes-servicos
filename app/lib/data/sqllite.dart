import 'dart:io';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SqliteConnection {
  Future<sql.Database> db() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    return sql.openDatabase(
      // 'C:\\Users\\Cauã Graff\\Documents\\dataservicos.db', // PC
      'D:\\UNC_ENG_SW_2022\\5 fase\\4 Desenvolvimento Mobile\\Trabalho\\dataservicos.db', //NOTE
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
    await database.execute('''
      CREATE TABLE servicos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cliente TEXT,
        descricao TEXT,
        data TEXT,
        quantidadeHoras REAL,
        valorUnitario REAL
      )
    ''');
  }
}
