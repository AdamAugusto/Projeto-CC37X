import 'dart:collection';
import 'package:flutter_projeto/modelos/colaborador.dart';
import 'package:flutter_projeto/modelos/evento.dart';
import 'package:flutter/material.dart';

class EventosComprados extends ChangeNotifier {
  static List<Evento> _tabelaComprados = [];

  UnmodifiableListView<Evento> get tabelaComprados =>
      UnmodifiableListView(_tabelaComprados);

  recuperarComprados(List<Evento> repositorio, Colaborador usuario) {
    _tabelaComprados = [];
    repositorio.forEach((evento) {
      evento.listaConvidados.forEach((user) {
        if (user == usuario.login) {
          _tabelaComprados.add(evento);
        }
      });
    });
    notifyListeners();
  }
}
