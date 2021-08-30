import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projeto/dataBases/db_firestore.dart';

import 'package:flutter_projeto/modelos/colaborador.dart';
import 'package:flutter_projeto/services/auth_service.dart';

class ColaboradorRepositorio extends ChangeNotifier {
  late Colaborador colaborador;
  late FirebaseFirestore db;
  late AuthService auth;
  bool iniciado = false;

  //get colaborador => _colaborador;

  ColaboradorRepositorio({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _recuperaColaborador();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  recuperaColaborador() async {
    await _recuperaColaborador();
  }

  _recuperaColaborador() async {
    iniciado = false;
    if (auth.usuario != null) {
      final snapShot =
          await db.collection('usuario/${auth.usuario!.uid}/dados').get();
      snapShot.docs.forEach((element) {
        final dados = element.data();
        bool check = dados['colaborador'];
        if (check) {
          colaborador = Colaborador.real(
              nome: dados['nome'],
              agencia: dados['agencia'],
              operacao: dados['operacao'],
              conta: dados['conta'],
              colaborador: dados['colaborador']);
        } else {
          colaborador = Colaborador(nome: dados['nome']);
        }
      });
      iniciado = true;
      notifyListeners();
    }
  }

  mantemColaborador(Colaborador col) async {
    await _mantemColaborador(col);
  }

  _mantemColaborador(Colaborador col) async {
    if (auth.usuario != null) {
      await db.collection('usuario/${auth.usuario!.uid}/dados').add({
        'nome': col.nome,
        'colaborador': false,
      });
      colaborador = col;
      notifyListeners();
    }
  }

  mantemColaboradorReal(Colaborador col) async {
    await _mantemColaboradorReal(col);
  }

  _mantemColaboradorReal(Colaborador col) async {
    if (auth.usuario != null) {
      await db.collection('usuario/${auth.usuario!.uid}/dados').add({
        'nome': col.nome,
        'agencia': col.agencia,
        'operacao': col.operacao,
        'conta': col.conta,
        'colaborador': true,
      });
      colaborador = col;
      notifyListeners();
    }
  }
}
