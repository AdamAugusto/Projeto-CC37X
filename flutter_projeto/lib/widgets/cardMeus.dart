import 'package:flutter/material.dart';
import 'package:flutter_projeto/modelos/evento.dart';
import 'package:flutter_projeto/repositotio/eventosGerais.dart';
import 'package:intl/intl.dart';

class CardMeus extends StatefulWidget {
  final EventosGerais eventosGerais;
  final Evento evento;
  const CardMeus({Key? key, required this.evento, required this.eventosGerais})
      : super(key: key);

  @override
  _CardMeusState createState() => _CardMeusState();
}

class _CardMeusState extends State<CardMeus> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
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
                PopupMenuItem(
                  child: ListTile(
                    title: Text('Remover'),
                    onTap: () {
                      widget.eventosGerais.remover(widget.evento);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            contentPadding: EdgeInsets.only(left: 16),
            subtitle: Text(
              'Data:${widget.evento.data}\n' +
                  '${real.format(widget.evento.preco)}\n' +
                  '${widget.evento.local}\n' +
                  'Totais: ${widget.evento.ingressosIniciais}\n' +
                  'Disponiveis: ${widget.evento.ingressos}',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
