import 'package:chat/core/models/chat_user.dart';

abstract class AuthService {
  ChatUser? get currentUser;
  
  // Lança novo dado conforme mudar o estado do usuário
  Stream<ChatUser?> get userChanges;

  // Métodos para alterar o estato do usuário atual
  Future<void> signup(
    String username, 
    String nome, 
    String email, 
    String password
  );
  
  Future<void> login(
    String username, 
    String password
  );
  
  Future<void> logout();
}