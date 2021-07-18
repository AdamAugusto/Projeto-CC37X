import 'package:flutter/material.dart';
import 'package:flutter_projeto/repositotio/colaboradorRepository.dart';
import 'package:flutter_projeto/repositotio/eventosComprados.dart';
import 'package:flutter_projeto/repositotio/eventosMeus.dart';
import 'package:provider/provider.dart';
import 'aplicativo/myApp.dart';
import 'package:flutter_projeto/repositotio/eventosGerais.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => EventosGerais(),
      ),
      ChangeNotifierProvider(
        create: (context) => ColaboradorRepositorio(),
      ),
      ChangeNotifierProvider(
        create: (context) => EventosComprados(),
      ),
      ChangeNotifierProvider(
        create: (context) => EventosMeus(),
      ),
    ],
    child: MyApp(),
  ));
}
