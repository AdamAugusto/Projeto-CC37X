import 'dart:collection';

import 'package:flutter_projeto/modelos/colaborador.dart';
import 'package:flutter_projeto/modelos/evento.dart';
import 'package:flutter/material.dart';

class EventosGerais extends ChangeNotifier {
  List<Evento> _tabelaGerais = [];

  UnmodifiableListView<Evento> get tabelaGerais =>
      UnmodifiableListView(_tabelaGerais);

  adicionar(Evento evento) {
    _tabelaGerais.add(evento);
    notifyListeners();
  }

  remover(Evento evento) {
    _tabelaGerais.remove(evento);
    notifyListeners();
  }

  adicionarConvidado(Evento evento, Colaborador user, int quant) {
    for (int i = 0; i < quant; i++) {
      evento.listaConvidados.add(user.login);
    }
    notifyListeners();
  }

  comprar(Evento evento, int quant, Colaborador user) {
    evento.ingressos = evento.ingressos - quant;
    for (int i = 0; i < quant; i++) {
      evento.listaConvidados.add(user.login);
    }
    notifyListeners();
  }
}
