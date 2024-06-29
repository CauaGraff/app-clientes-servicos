import 'package:app/components/container.dart';
import 'package:app/data/repositorios/clientes.dart';
import 'package:flutter/material.dart';

class CadastroClientesPage extends StatefulWidget {
  const CadastroClientesPage({super.key, required this.title});

  final String title;

  @override
  State<CadastroClientesPage> createState() => _CadastroClientesPageState();
}

class _CadastroClientesPageState extends State<CadastroClientesPage> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController enderecoController = TextEditingController();

  void salvar(BuildContext context) async {
    final clienteRepository = ClienteRepository();
    await clienteRepository.salvar(nomeController.text, telefoneController.text,
        emailController.text, enderecoController.text);
    Navigator.of(context).pushNamed('/clientes');
  }
List listar(Bl)
List<Map<String, dynamic>> clientes = await DatabaseHelper.listarClientes();
  print('Clientes: $clientes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ESContainer(
        widgets: [
          TextFormField(
              controller: nomeController,
              decoration: const InputDecoration(hintText: 'Nome')),
          TextFormField(
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Email')),
          TextFormField(
              controller: enderecoController,
              decoration: const InputDecoration(hintText: 'Endereço')),
          TextFormField(
              controller: telefoneController,
              decoration: const InputDecoration(hintText: 'Telefone')),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                salvar(context);
              },
              child: const Text('Salvar'))
        ],
      ),
    );
  }
}
