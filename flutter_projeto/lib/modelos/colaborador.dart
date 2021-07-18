import 'evento.dart';

class Colaborador {
  String? foto;
  String nome;
  String login;
  String senha;
  List<Evento> eventos = [];
  List<Evento> meusEventos = [];
  String? agencia;
  String? operacao;
  String? conta;
  bool colaborador = false;

  Colaborador({
    required this.nome,
    required this.login,
    required this.senha,
  });

  Colaborador.real(
      {required this.nome,
      required this.login,
      required this.senha,
      required this.agencia,
      required this.operacao,
      required this.conta,
      required this.colaborador});
}
