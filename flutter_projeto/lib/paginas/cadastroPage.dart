import 'package:flutter/material.dart';
import 'package:flutter_projeto/modelos/colaborador.dart';
import 'package:flutter_projeto/paginas/continuaCadastroPage.dart';
import 'package:flutter_projeto/services/auth_service.dart';
import 'package:provider/provider.dart';

class CadastroPage extends StatefulWidget {
  CadastroPage({
    Key? key,
  }) : super(key: key);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  bool checked = false;
  final _email = TextEditingController();
  final _email2 = TextEditingController();
  final _senha = TextEditingController();
  final _senha2 = TextEditingController();
  final _agencia = TextEditingController();
  final _operacao = TextEditingController();
  final _conta = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _nome = TextEditingController();
  bool loading = false;

  registrar() async {
    setState() => loading = true;
    try {
      await context.read<AuthService>().registrar(_email.text, _senha.text);
    } on AuthExecption catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  login() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().login(_email.text, _senha.text);
    } on AuthExecption catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Criar Login',
          style: TextStyle(),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nome,
                  style: TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return 'Informe o nome';
                  },
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                ),
                TextFormField(
                  controller: _email,
                  style: TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'E-mail',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return 'Informe o e-mail';
                    if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$'%&\*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+([a-zA-Z.]+)*")
                        .hasMatch(value)) return 'Formato de e-mail inválido';
                  },
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                ),
                TextFormField(
                  controller: _email2,
                  style: TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirmar E-mail',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return 'Confirme o e-mail';
                    if (value != _email.text)
                      return 'Os e-mails devem ser iguais';
                  },
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                ),
                TextFormField(
                  controller: _senha,
                  style: TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return 'Informe a senha';
                  },
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                ),
                TextFormField(
                  controller: _senha2,
                  style: TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirmar Senha',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return 'Confirme a senha';
                    if (value != _senha.text)
                      return 'As senhas devem ser iguais';
                  },
                ),
                Container(
                  child: Row(
                    children: [
                      Checkbox(
                          onChanged: (value) {
                            setState(() {
                              checked = !checked;
                            });
                          },
                          value: checked),
                      Text(
                        'Ser um Colaborador',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ),
                (checked)
                    ? Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _agencia,
                              style: TextStyle(fontSize: 22),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Agência',
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'Informe a agência de sua Conta';
                              },
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 8),
                            ),
                            TextFormField(
                              controller: _operacao,
                              style: TextStyle(fontSize: 22),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Operação',
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'Informe a operação de sua Conta';
                              },
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 8),
                            ),
                            TextFormField(
                              controller: _conta,
                              style: TextStyle(fontSize: 22),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Conta',
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'Informe o número de sua Conta';
                              },
                            ),
                          ],
                        ),
                      )
                    : Padding(padding: EdgeInsets.all(0)),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(top: 24),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        registrar();

                        login();
                        if (!checked) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ContinuaCadastroPage(
                                    colaborador:
                                        Colaborador(nome: _nome.text))),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ContinuaCadastroPage(
                                  colaborador: Colaborador.real(
                                      nome: _nome.text,
                                      agencia: _agencia.text,
                                      operacao: _operacao.text,
                                      conta: _conta.text,
                                      colaborador: true)),
                            ),
                          );
                        }
                      }
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
                              Icon(Icons.check),
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'Registrar',
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
