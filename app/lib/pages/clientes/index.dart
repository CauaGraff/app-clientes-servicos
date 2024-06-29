import 'package:app/components/container.dart';
import 'package:app/data/repositorios/clientes.dart';
import 'package:flutter/material.dart';

class ListaClientesPage extends StatefulWidget {
  const ListaClientesPage({super.key, required this.title});

  final String title;

  @override
  State<ListaClientesPage> createState() => _ListaClientesPageState();
}

class _ListaClientesPageState extends State<ListaClientesPage> {
  late Future<List<Map<String, dynamic>>> _clientes;

  @override
  void initState() {
    super.initState();
    _fetchClientes();
  }

  void _fetchClientes() {
    _clientes = ClienteRepository().getClientes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/clientes/cadastrar');
            },
            child: const Text('Cadastrar'),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _clientes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No clients found.'));
                } else {
                  final clientes = snapshot.data!;
                  return ListView.builder(
                    itemCount: clientes.length,
                    itemBuilder: (context, index) {
                      final cliente = clientes[index];
                      return ListTile(
                        title: Text(
                            '${cliente['nome']} - ${cliente['telefone']} - ${cliente['email']}'),
                        subtitle: Text(cliente['endereco']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Navigate to edit page with client data
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                await ClienteRepository()
                                    .deletar(cliente['id']);
                                setState(() {
                                  _fetchClientes();
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
