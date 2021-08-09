import 'package:flutter/material.dart';
import 'package:flutter_projeto/modelos/evento.dart';
import 'package:flutter_projeto/paginas/comprarIngresso.dart';

import 'package:flutter_projeto/repositotio/eventosGerais.dart';
import 'package:intl/intl.dart';

class CardGerais extends StatefulWidget {
  final EventosGerais eventosGerais;
  final Evento evento;

  CardGerais({
    Key? key,
    required this.eventosGerais,
    required this.evento,
  }) : super(key: key);

  @override
  _CardGerais createState() => _CardGerais();
}

class _CardGerais extends State<CardGerais> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      borderOnForeground: true,
      shadowColor: Colors.purple[900],
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.evento.nome,
              style: TextStyle(
                fontSize: 26,
              ),
            ),
            trailing: PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.purple,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: ListTile(
                    title: Text('Editar'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            contentPadding: EdgeInsets.only(left: 16),
            subtitle: Text(
              'Data: ${widget.evento.data}\n' +
                  '${real.format(widget.evento.preco)}\n' +
                  '${widget.evento.local}\n' +
                  'Disponiveis: ${widget.evento.ingressos}',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  if (widget.evento.ingressos > 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ComprarIngressoPage(
                                evento: widget.evento,
                                repositorioEventos: widget.eventosGerais,
                              )),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Evento Esgotado')));
                  }
                },
                child: Text('Comprar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
