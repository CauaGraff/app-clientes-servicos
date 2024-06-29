import 'package:app/components/container.dart';
import 'package:flutter/material.dart';

class ListaClientesPage extends StatefulWidget {
  const ListaClientesPage({super.key, required this.title});

  final String title;

  @override
  State<ListaClientesPage> createState() => _ListaClientesPageState();
}

class _ListaClientesPageState extends State<ListaClientesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ESContainer(
        widgets: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/clientes/cadastrar');
              },
              child: const Text('Cadastrar'))
        ],
      ),
    );
  }
}
