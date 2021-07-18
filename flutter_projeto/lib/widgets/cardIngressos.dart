import 'package:flutter/material.dart';
import 'package:flutter_projeto/modelos/evento.dart';
import 'package:intl/intl.dart';

class CardIngressos extends StatefulWidget {
  final Evento evento;

  const CardIngressos({Key? key, required this.evento}) : super(key: key);

  @override
  _CardIngressosState createState() => _CardIngressosState();
}

class _CardIngressosState extends State<CardIngressos> {
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
                    title: Text('Imprimir'),
                    onTap: () {},
                  ),
                ),
              ],
            ),
            contentPadding: EdgeInsets.only(left: 16),
            subtitle: Text(
              'Data:${widget.evento.data}\n' +
                  '${real.format(widget.evento.preco)}\n' +
                  '${widget.evento.local}',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
