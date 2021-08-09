import 'package:flutter/material.dart';

import 'package:flutter_projeto/paginas/cadastroPage.dart';
import 'package:flutter_projeto/paginas/esqueciSenhaPage.dart';
import 'package:flutter_projeto/repositotio/colaboradorRepository.dart';
import 'package:flutter_projeto/repositotio/eventosGerais.dart';
import 'package:flutter_projeto/services/auth_service.dart';
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
  bool loading = false;
  late EventosGerais eventosGerais;
  late ColaboradorRepositorio col;

  login() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().login(_login.text, _senha.text);
    } on AuthExecption catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
    eventosGerais.recuperarComprados();
    eventosGerais.recuperarMeus();
    col.recuperaColaborador();
  }

  @override
  Widget build(BuildContext context) {
    eventosGerais = Provider.of<EventosGerais>(context);
    col = Provider.of<ColaboradorRepositorio>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
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
                  labelText: 'E-mail',
                  prefixIcon: Icon(Icons.login),
                ),
                validator: (value) {
                  if (value!.isEmpty) return 'Informe o seu e-mail';
                  if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$'%&\*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+([a-zA-Z.]+)*")
                      .hasMatch(value)) return 'Formato de e-mail inválido';
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
                          builder: (_) => CadastroPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Não possuo cadastro',
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
                      login();
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
      ),
    );
  }
}
