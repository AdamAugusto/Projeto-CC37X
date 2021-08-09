import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_projeto/dataBases/db_firestore.dart';
import 'package:flutter_projeto/modelos/evento.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projeto/services/auth_service.dart';

class EventosGerais extends ChangeNotifier {
  List<Evento> _tabelaGerais = [];
  static List<Evento> _tabelaComprados = [];
  static List<Evento> _tabelaMeus = [];
  late FirebaseFirestore db;
  late AuthService auth;

  UnmodifiableListView<Evento> get tabelaGerais =>
      UnmodifiableListView(_tabelaGerais);

  UnmodifiableListView<Evento> get tabelaComprados =>
      UnmodifiableListView(_tabelaComprados);

  UnmodifiableListView<Evento> get tabelaMeus =>
      UnmodifiableListView(_tabelaMeus);

  EventosGerais({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _recuperaEventos();
    await _recuperarComprados();
    await _recuperarMeus();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _recuperaEventos() async {
    var snapshot = await db.collection('eventos').get();
    snapshot.docs.forEach((event) async {
      final dados = event.data();
      Evento oEvento = Evento(
        id: event.id,
        criador: dados['criador'],
        data: dados['data'],
        ingressosIniciais: dados['ingressosIniciais'],
        ingressos: dados['ingressos'],
        nome: dados['nome'],
        preco: dados['preco'],
        local: dados['local'],
      );
      var convidados =
          await db.collection('eventos/${event.id}/convidados').get();
      convidados.docs.forEach((convidado) {
        final conv = convidado.data();
        oEvento.listaConvidados.add(conv['nome']);
      });
      _tabelaGerais.add(oEvento);
    });
    notifyListeners();
  }

  recuperarMeus() async {
    await _recuperarMeus();
  }

  _recuperarMeus() async {
    _tabelaMeus = [];
    if (auth.usuario != null) {
      final snapShot = await db
          .collection('eventos')
          .where('criador', isEqualTo: auth.usuario!.email)
          .get();
      snapShot.docs.forEach((event) {
        final dados = event.data();
        _tabelaMeus.add(Evento(
          nome: dados['nome'],
          local: dados['local'],
          data: dados['data'],
          preco: dados['preco'],
          criador: dados['criador'],
          ingressosIniciais: dados['ingressosIniciais'],
          ingressos: dados['ingressos'],
        ));
      });
      notifyListeners();
    }
  }

  recuperarComprados() async {
    await _recuperarComprados();
  }

  _recuperarComprados() async {
    _tabelaComprados = [];
    if (auth.usuario != null) {
      final snapshot =
          await db.collection('usuario/${auth.usuario!.uid}/ingresso').get();
      snapshot.docs.forEach((event) {
        final dados = event.data();
        _tabelaComprados.add(Evento(
          nome: dados['nome'],
          local: dados['local'],
          data: dados['data'],
          preco: dados['preco'],
          criador: '0',
          ingressos: 0,
          ingressosIniciais: 0,
        ));
      });
      notifyListeners();
    }
  }

  adicionar(Evento evento) async {
    //_tabelaGerais.add(evento);
    //notifyListeners();
    var docRef = await db.collection('eventos').add({
      'nome': evento.nome,
      'local': evento.local,
      'data': evento.data,
      'ingressosIniciais': evento.ingressosIniciais,
      'ingressos': evento.ingressos,
      'preco': evento.preco,
      'criador': evento.criador,
    });
    evento.id = docRef.id;

    _tabelaMeus.add(evento);
    _tabelaGerais.add(evento);
    notifyListeners();
  }

  comprar(Evento evento, int quant) async {
    var numero = evento.ingressos - quant;
    var nome = auth.usuario!.email!;
    await db.collection('eventos').doc(evento.id).update({
      'ingressos': numero,
    });
    await db.collection('eventos/${evento.id}/convidados').add({
      'nome': nome,
    });
    for (int i = 0; i < quant; i++) {
      await db.collection('usuario/${auth.usuario!.uid}/ingresso').add({
        'nome': evento.nome,
        'local': evento.local,
        'data': evento.data,
        'preco': evento.preco,
      });
      _tabelaComprados.add(evento);
    }
    evento.ingressos = evento.ingressos - quant;
    evento.listaConvidados.add(auth.usuario!.email!);

    notifyListeners();
  }
}
