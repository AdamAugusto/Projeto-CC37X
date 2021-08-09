import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_projeto/modelos/colaborador.dart';
import 'package:flutter_projeto/repositotio/colaboradorRepository.dart';
import 'package:flutter_projeto/services/auth_service.dart';
import 'package:flutter_projeto/widgets/authCheck.dart';
import 'package:provider/provider.dart';

class ContinuaCadastroPage extends StatefulWidget {
  final Colaborador colaborador;
  const ContinuaCadastroPage({Key? key, required this.colaborador})
      : super(key: key);

  @override
  _ContinuaCadastroPageState createState() => _ContinuaCadastroPageState();
}

class _ContinuaCadastroPageState extends State<ContinuaCadastroPage> {
  late ColaboradorRepositorio col;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    col = Provider.of<ColaboradorRepositorio>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Cadastro realizado com sucesso',
                style: TextStyle(fontSize: 22, color: Colors.purple[800]),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 24),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (!widget.colaborador.colaborador) {
                    await col.mantemColaborador(widget.colaborador);
                  } else {
                    await col.mantemColaboradorReal(widget.colaborador);
                  }
                  loading = true;
                  Timer(Duration(seconds: 3), () {
                    context.read<AuthService>().logout();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AuthCheck(),
                      ),
                    );
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: (loading)
                      ? [
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ]
                      : [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Continuar',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                ),
              )
            ]),
      ),
    );
  }
}
