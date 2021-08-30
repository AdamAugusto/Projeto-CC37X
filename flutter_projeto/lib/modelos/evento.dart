import 'package:image_picker/image_picker.dart';

class Evento {
  String? id;
  String nome;
  String local;
  String? placeId;
  String data;
  int ingressosIniciais;
  int ingressos;
  double preco;
  String criador;
  List<String> listaConvidados = [];
  String? imagem;

  Evento(
      {this.id,
      required this.nome,
      required this.local,
      required this.placeId,
      required this.data,
      required this.ingressosIniciais,
      required this.ingressos,
      required this.preco,
      required this.criador,
      this.imagem});
}
