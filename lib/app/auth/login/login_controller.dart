import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:project_r/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';



final authProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authControllerProvider = StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(ref);
});




class AuthController extends StateNotifier<bool> {
  AuthController(this.ref) : super(false);

  final Ref ref;

  Future<Map?> login(String email, String password) async {
    state = true;

    try {
      final auth = ref.read(authProvider);
      final res = await auth.login(email, password);

      if (res != null && res["status"] == "success") {
        final prefs = await SharedPreferences.getInstance();

        final data = res["data"];

        await prefs.setString("id", data["id"].toString());
        await prefs.setString("username", data["username"].toString());
        await prefs.setString("email", data["email"].toString());
      }

      return res;
    } finally {
      state = false;
    }
  }


  
}