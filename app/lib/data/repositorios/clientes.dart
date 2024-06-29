import 'package:app/data/sqllite.dart';

class ClienteRepository {
  Future<List<Map<String, dynamic>>> getClientes() async {
    final sqlite = SqliteConnection();
    final connection = await sqlite.db();
    return await connection.query('clientes');
  }

  Future<void> salvar(
      String nome, String telefone, String email, String endereco) async {
    final sqlite = SqliteConnection();
    final connection = await sqlite.db();

    await connection.insert('clientes', {
      'nome': nome,
      'telefone': telefone,
      'email': email,
      'endereco': endereco
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
      'clientes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
