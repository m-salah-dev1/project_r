import 'package:project_r/components/crud.dart';
import 'package:project_r/constant/linkapi.dart';

class AuthService {
  final Crud _crud = Crud();

  Future<Map?> login(String email, String password) async {
    return await _crud.postRequest(linkLogin, {
      "email": email,
      "password": password,
    });
  }

  Future<Map?> signUp(String username, String email, String password) async {
    return await _crud.postRequest(linkSignUp, {
      "username": username,
      "email": email,
      "password": password,
    });
  }
}