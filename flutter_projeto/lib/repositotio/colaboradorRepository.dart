import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:collection';

import 'package:flutter_projeto/modelos/colaborador.dart';
import 'package:flutter_projeto/paginas/homePage.dart';
import 'package:flutter_projeto/paginas/homePageColaborador.dart';

class ColaboradorRepositorio extends ChangeNotifier {
  List<Colaborador> _colaboradorRepositorio = [];

  UnmodifiableListView<Colaborador> get lista =>
      UnmodifiableListView(_colaboradorRepositorio);

  novoCadastro(
    Colaborador user,
  ) {
    _colaboradorRepositorio.forEach((usuario) {
      if (usuario.login == user.login) {}
    });
    _colaboradorRepositorio.add(user);
  }

  bool autentica(String login, String senha, BuildContext context,
      ColaboradorRepositorio col) {
    bool flag = false;
    _colaboradorRepositorio.forEach((user) {
      if (user.login == login && user.senha == senha && user.colaborador) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HomePageColaborador(
              repositorio: col,
              user: user,
            ),
          ),
        );
        flag = true;
      } else if (user.login == login && user.senha == senha) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HomePage(
              repositorio: col,
              user: user,
            ),
          ),
        );
        flag = true;
      }
    });

    return flag;
  }

  ColaboradorRepositorio() {
    _colaboradorRepositorio.add(Colaborador.real(
      agencia: '2975',
      conta: '00006857-7',
      login: 'colaborador',
      nome: 'Adam',
      operacao: '013',
      senha: 'senha',
      colaborador: true,
    ));
    _colaboradorRepositorio.add(Colaborador(
      login: 'usuario',
      nome: 'Adam',
      senha: 'senha',
    ));
  }
}
