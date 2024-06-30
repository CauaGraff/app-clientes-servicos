import 'package:app/pages/clientes/formcadastro.dart';
import 'package:app/pages/home.dart';
import 'package:app/pages/clientes/index.dart';
import 'package:app/pages/servicos/formcadastro.dart';
import 'package:app/pages/servicos/index.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serviços',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const MyHomePage(title: 'Home'),
        '/clientes': (context) => const ListaClientesPage(title: 'Clientes'),
        '/clientes/cadastrar': (context) =>
            const CadastroClientesPage(title: 'Clientes Cadastro'),
        '/servicos': (context) => const ListaServicosPage(title: 'Serviços'),
        '/servicos/cadastrar': (context) =>
            const CadastroServicosPage(title: 'Serviços Cadastro'),
      },
    );
  }
}
