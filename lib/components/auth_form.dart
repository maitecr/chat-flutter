import 'package:chat/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {

  final void Function(AuthFormData) onSubmit; //Função para passar os dados para o componente pai

  const AuthForm({
    super.key,
    required this.onSubmit
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {

  final _formKey = GlobalKey<FormState>();
  final _authFormData = AuthFormData();

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if(!isValid) return;

    widget.onSubmit(_authFormData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                key: ValueKey('username'),
                initialValue: _authFormData.username,           // Assim, os valores persistirão na alternância do form
                onChanged: (username) => _authFormData.username = username,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (_username) {
                  final username = _username ?? '';
                  if(username.trim().length < 5) {
                    return 'Username deve ter pelo menos 5 caracteres.';
                  }
                  return null;
                },
              ),

              if (_authFormData.isSignup) // Nome apenas aparecerá no form de cadastro
                TextFormField(
                  key: ValueKey('name'),
                  initialValue: _authFormData.name,
                  onChanged: (name) => _authFormData.name = name,
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (_name) {
                    final name = _name ?? '';
                    if(name.trim().length < 3) {
                      return 'Nome deve ter pelo menos 3 caracteres.';
                    }
                    return null;
                  } ,
                ),
              if (_authFormData.isSignup) // E-mail apenas aparecerá no form de cadastro
                TextFormField(
                  key: ValueKey('email'),
                  initialValue: _authFormData.email,
                  onChanged: (email) => _authFormData.email = email,
                  decoration: InputDecoration(labelText: 'E-mail'),
                  validator: (_email) {
                    final email = _email ?? '';
                    if(!email.contains('@')) {
                      return 'E-mail inválido.';
                    }
                    return null;
                  },
                ),

              TextFormField(
                key: ValueKey('password'),
                initialValue: _authFormData.password,
                onChanged: (password) => _authFormData.password = password,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Senha'),
                validator: (_password) {
                  final password = _password ?? '';
                  if(password.length < 6) {
                    return 'Senha deve ter 6 caracteres';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: _submit, 
                child: Text(_authFormData.isLogin ? 'Entrar' : 'Cadastrar')
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _authFormData.toggleAuthMode();
                  });
                }, 
                child: Text(_authFormData.isLogin ? 'Criar nova conta?' : 'Já possui conta?')
              )
            ],
          ),
        ),
      ),
    );
  }
}