import 'package:flutter/material.dart';

import 'package:flutter_projeto/paginas/cadastroPage.dart';
import 'package:flutter_projeto/paginas/esqueciSenhaPage.dart';
import 'package:flutter_projeto/repositotio/colaboradorRepository.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _login = TextEditingController();
  final _senha = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool flag = false;

  late ColaboradorRepositorio colaboradorRepositorio;

  @override
  Widget build(BuildContext context) {
    colaboradorRepositorio = Provider.of<ColaboradorRepositorio>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Consumer<ColaboradorRepositorio>(
          builder: (context, colaboradorRepositorio, child) {
        return Padding(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _login,
                  style: TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Usuário',
                    prefixIcon: Icon(Icons.login),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return 'Informe o seu usuário';
                  },
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 24),
                ),
                TextFormField(
                  obscureText: true,
                  controller: _senha,
                  style: TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
                    prefixIcon: Icon(Icons.password),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return 'Informe a sua senha';
                  },
                ),
                Container(
                  alignment: Alignment(1, 0),
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 10),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => EsqueciSenhaPage()),
                      );
                    },
                    child: Text(
                      'Esqueci minha senha',
                      style: TextStyle(
                        color: Colors.blue[600],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  //width: double.infinity,
                  //padding: EdgeInsets.only(top: 10),
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CadastroPage(
                              repositorio: colaboradorRepositorio,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Não possuo login',
                        style: TextStyle(
                          color: Colors.blue[600],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(top: 24),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        flag = colaboradorRepositorio.autentica(_login.text,
                            _senha.text, context, colaboradorRepositorio);
                        if (!flag) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Usuário e/ou senha incorretos')));
                        } else {
                          _login.clear();
                          _senha.clear();
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
                            'Login',
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
        );
      }),
    );
  }
}
