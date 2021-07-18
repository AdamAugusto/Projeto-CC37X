import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_projeto/modelos/colaborador.dart';
import 'package:flutter_projeto/modelos/evento.dart';

class EventosMeus extends ChangeNotifier {
  static List<Evento> _tabelaMeus = [];

  UnmodifiableListView<Evento> get tabelaMeus =>
      UnmodifiableListView(_tabelaMeus);

  recuperarMeus(List<Evento> repositorio, Colaborador user) {
    _tabelaMeus = [];
    repositorio.forEach((evento) {
      if (evento.criador == user) {
        _tabelaMeus.add(evento);
      }
    });
    notifyListeners();
  }
}
