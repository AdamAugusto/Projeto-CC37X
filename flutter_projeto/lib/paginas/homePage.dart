import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_projeto/modelos/colaborador.dart';

import 'package:flutter_projeto/repositotio/colaboradorRepository.dart';
import 'package:flutter_projeto/repositotio/eventosComprados.dart';
import 'package:flutter_projeto/repositotio/eventosGerais.dart';
import 'package:flutter_projeto/widgets/cardGerais.dart';
import 'package:flutter_projeto/widgets/cardIngressos.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final Colaborador user;
  final ColaboradorRepositorio repositorio;

  HomePage({Key? key, required this.user, required this.repositorio})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  late EventosGerais eventosGerais;
  late EventosComprados eventosComprados;

  @override
  Widget build(BuildContext context) {
    eventosGerais = Provider.of<EventosGerais>(context);
    eventosComprados = Provider.of<EventosComprados>(context);
    eventosComprados.recuperarComprados(
        eventosGerais.tabelaGerais, widget.user);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
          //automaticallyImplyLeading: false,
          backgroundColor: Colors.purple[600],
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Eventos', icon: Icon(Icons.event)),
              Tab(text: 'Ingressos', icon: Icon(Icons.event_seat)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.separated(
              //1
              itemBuilder: (BuildContext context, int evento) {
                return CardGerais(
                    eventosGerais: eventosGerais,
                    evento: eventosGerais.tabelaGerais[evento],
                    repositorio: widget.repositorio,
                    user: widget.user);
              },
              separatorBuilder: (_, __) => Divider(),
              itemCount: eventosGerais.tabelaGerais.length,
            ),
            ListView.separated(
              //2
              itemBuilder: (BuildContext context, int evento) {
                return CardIngressos(
                    evento: eventosComprados.tabelaComprados[evento]);
              },
              separatorBuilder: (_, __) => Divider(),
              itemCount: eventosComprados.tabelaComprados.length,
            ),
          ],
        ),
      ),
    );
  }
}
