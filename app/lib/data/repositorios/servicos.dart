import 'dart:ffi';

import 'package:app/data/sqllite.dart';

class ServicosRepository {
  Future<List<Map<String, dynamic>>> getServicos() async {
    final sqlite = SqliteConnection();
    final connection = await sqlite.db();
    return await connection.query('servicos');
  }

  Future<void> salvar(String cliente, String descricao, String data,
      double quantidadeHoras, double valorUnitario) async {
    final sqlite = SqliteConnection();
    final connection = await sqlite.db();

    await connection.insert('servicos', {
      'cliente': cliente,
      'descricao': descricao,
      'data': data,
      'quantidadeHoras': quantidadeHoras,
      'valorUnitario': valorUnitario
    });
  }

  void atualizar() async {
    int id = 1;
    String nome = 'Josnei';
    double valor = 10;

    final sqlite = SqliteConnection();
    final connection = await sqlite.db();

    await connection.update('users', {'nome': nome, 'valor': valor},
        where: 'id = 1');
  }

  Future<void> deletar(int id) async {
    final sqlite = SqliteConnection();
    final connection = await sqlite.db();
    await connection.delete(
      'servicos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
