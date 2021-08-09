import 'evento.dart';

class Colaborador {
  String? foto;
  String nome;
  List<Evento> eventos = [];
  List<Evento> meusEventos = [];
  String? agencia;
  String? operacao;
  String? conta;
  bool colaborador = false;

  Colaborador({
    required this.nome,
  });

  Colaborador.real(
      {required this.nome,
      required this.agencia,
      required this.operacao,
      required this.conta,
      required this.colaborador});
}
