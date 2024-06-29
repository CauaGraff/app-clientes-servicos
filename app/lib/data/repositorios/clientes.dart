import 'package:app/data/sqllite.dart';

class ClienteRepository {
  void listar() async {
    final sqlite = SqliteConnection();
    final connection = await sqlite.db();
    List<Map<String, Object?>> usuarios = await connection.query('clientes');

    for (final usuario in usuarios) {
      int id = int.parse(usuario['id'].toString());
      String nome = usuario['nome'].toString();
      String telefone = usuario['telefone'].toString();
      String email = usuario['email'].toString();
      String endereco = usuario['endereco'].toString();
    }
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

  void deletar() async {
    final sqlite = SqliteConnection();
    final connection = await sqlite.db();
    await connection.delete('users', where: 'id = 1');
  }
}
