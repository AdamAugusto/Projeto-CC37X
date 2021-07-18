import 'package:flutter/material.dart';
import 'package:flutter_projeto/modelos/colaborador.dart';

import 'package:flutter_projeto/paginas/cadastrarEventoPage.dart';
import 'package:flutter_projeto/repositotio/colaboradorRepository.dart';
import 'package:flutter_projeto/repositotio/eventosMeus.dart';
import 'package:flutter_projeto/repositotio/eventosComprados.dart';
import 'package:flutter_projeto/repositotio/eventosGerais.dart';
import 'package:flutter_projeto/widgets/cardGerais.dart';
import 'package:flutter_projeto/widgets/cardIngressos.dart';
import 'package:flutter_projeto/widgets/cardMeus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePageColaborador extends StatefulWidget {
  final ColaboradorRepositorio repositorio;
  final Colaborador user;

  HomePageColaborador({Key? key, required this.repositorio, required this.user})
      : super(key: key);

  @override
  _HomePageColaboradorState createState() => _HomePageColaboradorState();
}

class _HomePageColaboradorState extends State<HomePageColaborador> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  late EventosGerais eventosGerais;
  late EventosMeus eventosMeus;
  late EventosComprados eventosComprados;

  @override
  Widget build(BuildContext context) {
    eventosGerais = Provider.of<EventosGerais>(context);
    eventosComprados = Provider.of<EventosComprados>(context);
    eventosMeus = Provider.of<EventosMeus>(context);
    eventosComprados.recuperarComprados(
        eventosGerais.tabelaGerais, widget.user);

    eventosMeus.recuperarMeus(eventosGerais.tabelaGerais, widget.user);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Colors.purple[600],
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CadastrarEventoPage(
                          evento: eventosGerais,
                          repositorio: widget.repositorio,
                          user: widget.user),
                    ),
                  );
                }),
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Eventos', icon: Icon(Icons.event)),
              Tab(text: 'Ingressos', icon: Icon(Icons.event_seat)),
              Tab(text: 'Meus Eventos', icon: Icon(Icons.event_available)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Consumer<EventosGerais>(
              builder: (context, eventosGerais, child) {
                return ListView.separated(
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
                );
              },
            ),
            Consumer<EventosComprados>(
              builder: (context, eventosComprados, child) {
                return ListView.separated(
                  //2
                  itemBuilder: (BuildContext context, int evento) {
                    return CardIngressos(
                        evento: eventosComprados.tabelaComprados[evento]);
                  },
                  separatorBuilder: (_, __) => Divider(),
                  itemCount: eventosComprados.tabelaComprados.length,
                );
              },
            ),
            Container(
              child:
                  Consumer<EventosMeus>(builder: (context, eventosMeus, child) {
                return ListView.separated(
                  //3
                  itemBuilder: (BuildContext context, int evento) {
                    return CardMeus(
                      evento: eventosMeus.tabelaMeus[evento],
                      eventosGerais: eventosGerais,
                    );
                  },
                  separatorBuilder: (_, __) => Divider(),
                  itemCount: eventosMeus.tabelaMeus.length,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
