import 'package:flutter/material.dart';
import 'package:flutter_projeto/paginas/homePage.dart';
import 'package:flutter_projeto/paginas/homePageColaborador.dart';
import 'package:flutter_projeto/paginas/loginPage.dart';
import 'package:flutter_projeto/repositotio/colaboradorRepository.dart';
import 'package:flutter_projeto/services/auth_service.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  late ColaboradorRepositorio col;

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isLoading)
      return loading();
    else if (auth.usuario == null)
      return LoginPage();
    else {
      col = Provider.of<ColaboradorRepositorio>(context);

      if (col.colaborador.colaborador) {
        return HomePageColaborador();
      } else
        return HomePage();
    }
  }

  loading() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
