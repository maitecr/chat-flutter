// ignore_for_file: prefer_final_fields

import 'dart:math';

import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'dart:async';

class AuthMockService implements AuthService {
  
  static final _defaultUser = ChatUser(
    id: '1', 
    username: 'teste', 
    name: 'nome teste', 
    email: 'teste@email.com'
  ); 

  // Mesmo que sejam feitas várias instâncias de AuthMockService, ele vai retornar o mesmo usuário (static)
  static Map<String, ChatUser> _users = {
    _defaultUser.username: _defaultUser,
  };
  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>? _controller;
  static final _userStream = Stream<ChatUser?>.multi((controller) {
    _controller = controller;
    _updadeUser(_defaultUser);
  });
  
  @override
  ChatUser? get currentUser {
    return _currentUser;
  }

  @override
  Future<void> login(String username, String password) async {
    _updadeUser(_users[username]);
  }

  @override
  Future<void> logout() async {
    _updadeUser(null);
  }

  @override
  Future<void> signup(String username, String nome, String email, String password) async {
    final newUser = ChatUser(
      id: Random().nextDouble().toString(),
      username: username,
      name: nome,
      email: email, 
      );

    _users.putIfAbsent(username, () => newUser);
    _updadeUser(newUser);
  }

  @override
  Stream<ChatUser?> get userChanges {
    return _userStream;
  }


  static void _updadeUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}