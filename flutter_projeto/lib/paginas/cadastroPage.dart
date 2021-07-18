import 'package:flutter/material.dart';
import 'package:flutter_projeto/modelos/colaborador.dart';
import 'package:flutter_projeto/repositotio/colaboradorRepository.dart';

class CadastroPage extends StatefulWidget {
  final ColaboradorRepositorio repositorio;

  CadastroPage({Key? key, required this.repositorio}) : super(key: key);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  bool checked = false;
  final _login = TextEditingController();
  final _email = TextEditingController();
  final _email2 = TextEditingController();
  final _senha = TextEditingController();
  final _senha2 = TextEditingController();
  final _agencia = TextEditingController();
  final _operacao = TextEditingController();
  final _conta = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _nome = TextEditingController();
  late bool flag;

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
                  controller: _login,
                  style: TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Login',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return 'Informe o login';
                  },
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                ),
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
                        if (checked) {
                          flag = false;
                          widget.repositorio.lista.forEach((user) {
                            if (user.login == _login.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Este login já existe')));
                              flag = true;
                            }
                          });
                          if (!flag) {
                            widget.repositorio.novoCadastro(Colaborador.real(
                                nome: _nome.text,
                                login: _login.text,
                                senha: _senha.text,
                                agencia: _agencia.text,
                                operacao: _operacao.text,
                                conta: _conta.text,
                                colaborador: true));
                            Navigator.pop(context);
                          }
                        } else {
                          flag = false;
                          widget.repositorio.lista.forEach((user) {
                            if (user.login == _login.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Este login já existe')));
                              flag = true;
                            }
                          });
                          if (!flag) {
                            widget.repositorio.novoCadastro(Colaborador(
                              nome: _nome.text,
                              login: _login.text,
                              senha: _senha.text,
                            ));
                            Navigator.pop(context);
                          }
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check),
                        Padding(
                          padding: EdgeInsets.all(16),
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
