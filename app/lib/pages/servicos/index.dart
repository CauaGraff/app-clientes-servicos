import 'package:app/data/repositorios/servicos.dart';
import 'package:flutter/material.dart';

class ListaServicosPage extends StatefulWidget {
  const ListaServicosPage({super.key, required this.title});

  final String title;

  @override
  State<ListaServicosPage> createState() => _ListaServicosPageState();
}

class _ListaServicosPageState extends State<ListaServicosPage> {
  late Future<List<Map<String, dynamic>>> _servicos;

  @override
  void initState() {
    super.initState();
    _fetchServicos();
  }

  void _fetchServicos() {
    _servicos = ServicosRepository().getServicos();
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
              Navigator.of(context).pushNamed('/servicos/cadastrar');
            },
            child: const Text('Cadastrar'),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _servicos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No servicos found.'));
                } else {
                  final servicos = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('ID')),
                        DataColumn(label: Text('Cliente')),
                        DataColumn(label: Text('Descrição')),
                        DataColumn(label: Text('Data')),
                        DataColumn(label: Text('Quantidade de Horas')),
                        DataColumn(label: Text('Valor Unitário')),
                        DataColumn(label: Text('Ações')),
                      ],
                      rows: servicos.map((servico) {
                        return DataRow(cells: [
                          DataCell(Text(servico['id'].toString())),
                          DataCell(Text(servico['cliente'])),
                          DataCell(Text(servico['descricao'])),
                          DataCell(Text(servico['data'])),
                          DataCell(Text(servico['quantidadeHoras'].toString())),
                          DataCell(Text(servico['valorUnitario'].toString())),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () async {
                                    await ServicosRepository()
                                        .deletar(servico['id']);
                                    setState(() {
                                      _fetchServicos();
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ]);
                      }).toList(),
                    ),
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
