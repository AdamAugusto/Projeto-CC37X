import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projeto/repositotio/colaboradorRepository.dart';
import 'package:flutter_projeto/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'aplicativo/myApp.dart';
import 'package:flutter_projeto/repositotio/eventosGerais.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AuthService(),
      ),
      ChangeNotifierProvider(
        create: (context) => EventosGerais(auth: context.read<AuthService>()),
      ),
      ChangeNotifierProvider(
        create: (context) =>
            ColaboradorRepositorio(auth: context.read<AuthService>()),
      ),
    ],
    child: MyApp(),
  ));
}
