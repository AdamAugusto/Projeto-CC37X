import 'package:flutter/material.dart';
import 'package:flutter_projeto/paginas/cadastrarEventoPage.dart';
import 'package:flutter_projeto/repositotio/eventosGerais.dart';
import 'package:flutter_projeto/services/auth_service.dart';
import 'package:flutter_projeto/widgets/cardGerais.dart';
import 'package:flutter_projeto/widgets/cardIngressos.dart';
import 'package:flutter_projeto/widgets/cardMeus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePageColaborador extends StatefulWidget {
  HomePageColaborador({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageColaboradorState createState() => _HomePageColaboradorState();
}

class _HomePageColaboradorState extends State<HomePageColaborador> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  late EventosGerais eventosGerais;

  @override
  Widget build(BuildContext context) {
    eventosGerais = Provider.of<EventosGerais>(context);
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
                      builder: (_) =>
                          CadastrarEventoPage(evento: eventosGerais),
                    ),
                  );
                }),
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () => context.read<AuthService>().logout()),
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
                    );
                  },
                  separatorBuilder: (_, __) => Divider(),
                  itemCount: eventosGerais.tabelaGerais.length,
                );
              },
            ),
            Consumer<EventosGerais>(
              builder: (context, eventosComprados, child) {
                return ListView.separated(
                  //2
                  itemBuilder: (BuildContext context, int evento) {
                    return CardIngressos(
                        evento: eventosGerais.tabelaComprados[evento]);
                  },
                  separatorBuilder: (_, __) => Divider(),
                  itemCount: eventosGerais.tabelaComprados.length,
                );
              },
            ),
            Container(
              child: Consumer<EventosGerais>(
                  builder: (context, eventosMeus, child) {
                return ListView.separated(
                  //3
                  itemBuilder: (BuildContext context, int evento) {
                    return CardMeus(
                      evento: eventosGerais.tabelaMeus[evento],
                      eventosGerais: eventosGerais,
                    );
                  },
                  separatorBuilder: (_, __) => Divider(),
                  itemCount: eventosGerais.tabelaMeus.length,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
