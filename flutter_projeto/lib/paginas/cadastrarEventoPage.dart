import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_projeto/modelos/evento.dart';
import 'package:flutter_projeto/repositotio/eventosGerais.dart';
import 'package:flutter_projeto/services/auth_service.dart';
import 'package:provider/provider.dart';

class CadastrarEventoPage extends StatefulWidget {
  final EventosGerais evento;

  CadastrarEventoPage({
    Key? key,
    required this.evento,
  }) : super(key: key);

  @override
  _CadastrarEventoPageState createState() => _CadastrarEventoPageState();
}

class _CadastrarEventoPageState extends State<CadastrarEventoPage> {
  final _nomeEvento = TextEditingController();
  final _localEvento = TextEditingController();
  final _data = TextEditingController();
  final _ingresso = TextEditingController();
  final _preco = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastrar Evento',
          style: TextStyle(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nomeEvento,
                  style: TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome',
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) return 'Informe o nome do Evento';
                  },
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                ),
                TextFormField(
                  controller: _localEvento,
                  style: TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Local',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return 'Informe o local do Evento';
                  },
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                ),
                TextFormField(
                  controller: _data,
                  style: TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Data',
                      hintText: 'dd/mm/aaaa'),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value!.isEmpty) return 'Informe a data do Evento';
                    if (!RegExp(r'^(\d{1,2})\/(\d{1,2})\/(\d{4})')
                        .hasMatch(value))
                      return 'Data deve ser no formato: dd/mm/aaaa';
                  },
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                ),
                TextFormField(
                  controller: _ingresso,
                  style: TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Quantidade de Ingressos',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+')),
                  ],
                  validator: (value) {
                    if (value!.isEmpty)
                      return 'Informe a quantidade de ingressos do Evento';
                    if (!(int.parse(value) > 0)) {
                      return 'Informe uma quantidade válida de ingressos ';
                    }
                  },
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                ),
                TextFormField(
                  controller: _preco,
                  style: TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Preço do Ingresso',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                  ],
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty)
                      return 'Informe o preço dos ingressos do Evento';
                  },
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(top: 24),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        AuthService auth = context.read<AuthService>();
                        widget.evento.adicionar(
                          Evento(
                            nome: _nomeEvento.text,
                            data: _data.text,
                            local: _localEvento.text,
                            ingressos: int.parse(_ingresso.text),
                            ingressosIniciais: int.parse(_ingresso.text),
                            preco: double.parse(_preco.text),
                            criador: auth.usuario!.email!,
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'Salvar',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
