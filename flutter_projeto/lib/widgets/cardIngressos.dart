import 'dart:io';
import 'dart:ui';

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
    String mes = widget.evento.data.substring(3, 5);

    switch (mes) {
      case '01':
        mes = 'Jan';
        break;
      case '02':
        mes = 'Fev';
        break;
      case '03':
        mes = 'Mar';
        break;
      case '04':
        mes = 'Abr';
        break;
      case '05':
        mes = 'Mai';
        break;
      case '06':
        mes = 'Jun';
        break;
      case '07':
        mes = 'Jul';
        break;
      case '08':
        mes = 'Ago';
        break;
      case '09':
        mes = 'Sep';
        break;
      case '10':
        mes = 'Out';
        break;
      case '11':
        mes = 'Nov';
        break;
      case '12':
        mes = 'Dez';
        break;

      default:
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                '${widget.evento.data.substring(0, 2)}\n' +
                    mes +
                    '\n' +
                    '${widget.evento.data.substring(6, 10)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blueGrey[900],
                  fontSize: 26,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            VerticalDivider(
              color: Colors.purple[800],
              width: 0,
              thickness: 0.8,
              indent: 4,
              endIndent: 4,
            ),
            Expanded(
              child: Container(
                alignment: Alignment(0.05, 0),
                child: ListTile(
                  contentPadding: EdgeInsets.all(8),
                  title: Text(
                    '${widget.evento.nome}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  subtitle: Text(
                    '${widget.evento.local}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            VerticalDivider(
              color: Colors.purple[800],
              width: 0,
              thickness: 0.8,
              indent: 4,
              endIndent: 4,
            ),
            Container(
              alignment: Alignment(0.05, 0),
              child: widget.evento.imagem != null
                  ? Image.file(
                      File(widget.evento.imagem!),
                      height: 30,
                    )
                  : null,
            ),
            Container(
              alignment: Alignment(1, -1),
              child: PopupMenuButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.purple,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: ListTile(
                      title: Text('Imprimir'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
