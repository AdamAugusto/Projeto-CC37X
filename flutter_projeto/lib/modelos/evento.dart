import 'colaborador.dart';

class Evento {
  String nome;
  String local;
  String data;
  int ingressosIniciais;
  int ingressos;
  double preco;
  Colaborador criador;
  List<String> listaConvidados = [];

  Evento({
    required this.nome,
    required this.local,
    required this.data,
    required this.ingressosIniciais,
    required this.ingressos,
    required this.preco,
    required this.criador,
  });
}
