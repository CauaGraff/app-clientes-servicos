import 'dart:ffi';

import 'package:app/components/container.dart';
import 'package:app/data/repositorios/servicos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CadastroServicosPage extends StatefulWidget {
  const CadastroServicosPage({super.key, required this.title});

  final String title;

  @override
  State<CadastroServicosPage> createState() => _CadastroServicosPageState();
}

class _CadastroServicosPageState extends State<CadastroServicosPage> {
  TextEditingController clienteController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  TextEditingController qtdhorasController = TextEditingController();
  TextEditingController valorController = TextEditingController();

  void salvar(BuildContext context) async {
    final clienteRepository = ServicosRepository();
    await clienteRepository.salvar(
        clienteController.text,
        descricaoController.text,
        dataController.text,
        double.parse(qtdhorasController.text),
        double.parse(valorController.text));
    Navigator.of(context).pushNamed('/servicos');
  }

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
              controller: clienteController,
              decoration: const InputDecoration(hintText: 'Cliente')),
          TextFormField(
              controller: descricaoController,
              decoration: const InputDecoration(hintText: 'Descricao')),
          TextFormField(
              controller: dataController,
              decoration: const InputDecoration(hintText: 'Data')),
          TextFormField(
              controller: qtdhorasController,
              decoration:
                  const InputDecoration(hintText: 'Quantidade de Horas')),
          TextFormField(
              controller: valorController,
              decoration: const InputDecoration(hintText: 'Valor')),
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
