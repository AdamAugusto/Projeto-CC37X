import 'package:flutter/material.dart';
import 'package:flutter_projeto/modelos/evento.dart';

import 'package:flutter_projeto/repositotio/eventosGerais.dart';
import 'package:intl/intl.dart';

class ComprarIngressoPage extends StatefulWidget {
  final Evento evento;
  final EventosGerais repositorioEventos;

  ComprarIngressoPage({
    Key? key,
    required this.evento,
    required this.repositorioEventos,
  }) : super(key: key);

  @override
  _ComprarIngressoPageState createState() => _ComprarIngressoPageState();
}

class _ComprarIngressoPageState extends State<ComprarIngressoPage> {
  int quantidade = 0;
  double precoTotal = 0;
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.evento.nome,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            letterSpacing: -1,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    'Preço: ${real.format(widget.evento.preco)}\n' +
                        'Data: ${widget.evento.data}\n' +
                        'Local: ${widget.evento.local}\n' +
                        'Disponíveis: ${widget.evento.ingressos} ingressos\n' +
                        'Comprar: $quantidade ingressos',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.all(24)),
              Padding(padding: EdgeInsets.only(right: 24)),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (quantidade < widget.evento.ingressos) quantidade++;
                    precoTotal = quantidade * widget.evento.preco;
                  });
                },
                child: Row(
                  children: [
                    Icon(Icons.add),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(right: 24)),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (quantidade > 0) quantidade--;
                    precoTotal = quantidade * widget.evento.preco;
                  });
                },
                child: Row(
                  children: [
                    Icon(Icons.remove),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Preço total da Compra:\n' + '${real.format(precoTotal)}',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -1,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(24),
            child: ElevatedButton(
              onPressed: () {
                if (quantidade > 0) {
                  widget.repositorioEventos.comprar(widget.evento, quantidade);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Informe uma quantidade válida')));
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Comprar',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
