import 'package:chat/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {

  final _formKey = GlobalKey<FormState>();
  final _authFormData = AuthFormData();

  void _submit() {
    _formKey.currentState?.validate();
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
                onChanged: (username) => _authFormData.username,
                decoration: InputDecoration(labelText: 'Username'),
              ),

              if (_authFormData.isSignup) // Nome apenas aparecerá no form de cadastro
                TextFormField(
                  key: ValueKey('name'),
                  initialValue: _authFormData.name,
                  onChanged: (name) => _authFormData.name,
                  decoration: InputDecoration(labelText: 'Nome'),
                ),
              if (_authFormData.isSignup) // E-mail apenas aparecerá no form de cadastro
                TextFormField(
                  key: ValueKey('email'),
                  initialValue: _authFormData.email,
                  onChanged: (email) => _authFormData.email,
                  decoration: InputDecoration(labelText: 'E-mail'),
                ),

              TextFormField(
                key: ValueKey('password'),
                initialValue: _authFormData.password,
                onChanged: (password) => _authFormData.password,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Senha'),
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