class Evento {
  String? id;
  String nome;
  String local;
  String data;
  int ingressosIniciais;
  int ingressos;
  double preco;
  String criador;
  List<String> listaConvidados = [];

  Evento(
      {this.id,
      required this.nome,
      required this.local,
      required this.data,
      required this.ingressosIniciais,
      required this.ingressos,
      required this.preco,
      required this.criador});
}
