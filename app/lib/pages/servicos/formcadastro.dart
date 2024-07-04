import 'dart:ffi';
import 'package:app/components/container.dart';
import 'package:app/data/repositorios/servicos.dart';
import 'package:app/data/repositorios/clientes.dart'; // Importando o repositório de clientes
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

  List<Map<String, dynamic>> _clientes = [];
  int? _clienteSelecionadoId;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _loadClientes();
  }

  Future<void> _loadClientes() async {
    final clientes = await ClienteRepository().getClientes();
    setState(() {
      _clientes = clientes;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        dataController.text = "${picked.toLocal()}"
            .split(' ')[0]; // Formatar a data como yyyy-MM-dd
      });
    }
  }

  void salvar(BuildContext context) async {
    try {
      final clienteRepository = ServicosRepository();
      double quantidadeHoras = double.tryParse(qtdhorasController.text) ?? 0.0;
      double valor = double.tryParse(valorController.text) ?? 0.0;

      String clienteNome = _clientes.firstWhere(
          (cliente) => cliente['id'] == _clienteSelecionadoId)['nome'];

      await clienteRepository.salvar(
        clienteNome,
        descricaoController.text,
        dataController.text,
        quantidadeHoras,
        valor,
      );

      Navigator.of(context).pushNamed('/servicos');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar serviço: $e')),
      );
    }
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
          DropdownButton<int>(
            hint: Text('Selecionar Cliente'),
            value: _clienteSelecionadoId,
            items: _clientes.map((cliente) {
              return DropdownMenuItem<int>(
                value: cliente['id'],
                child: Text(cliente['nome']),
              );
            }).toList(),
            onChanged: (clienteId) {
              setState(() {
                _clienteSelecionadoId = clienteId;
                clienteController.text = _clientes.firstWhere(
                    (cliente) => cliente['id'] == clienteId)['nome'];
              });
            },
          ),
          TextFormField(
            controller: clienteController,
            decoration: const InputDecoration(hintText: 'Cliente'),
            readOnly: true, // Tornar o campo somente leitura
          ),
          TextFormField(
            controller: descricaoController,
            decoration: const InputDecoration(hintText: 'Descrição'),
          ),
          TextFormField(
            controller: dataController,
            decoration: const InputDecoration(hintText: 'Data'),
            readOnly: true,
            onTap: () => _selectDate(context),
          ),
          TextFormField(
            controller: qtdhorasController,
            decoration: const InputDecoration(hintText: 'Quantidade de Horas'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          TextFormField(
            controller: valorController,
            decoration: const InputDecoration(hintText: 'Valor'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              salvar(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }
}
