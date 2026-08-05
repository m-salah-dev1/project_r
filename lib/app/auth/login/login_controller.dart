import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:project_r/app/auth/repo.dart';
import 'package:project_r/auth_service.dart';
import 'package:project_r/constant/authstate.dart';
import 'package:project_r/components/function.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authControllerProvider = StateNotifierProvider<AuthController, Authstate>(
  (ref) {
    return AuthController(ref);
  },
);

class AuthController extends StateNotifier<Authstate> {
  final Ref ref;

  final AuthService authService = AuthService();

  AuthController(this.ref) : super(Authstate());

  Future<UserCredential?> login(String email, String password) async {
    if (!await checkInternet()) {
      state = Authstate(
        status: Authstatus.offline,
        message: "no Internet Connectio",
      );
      return null;
    }

    state = Authstate(status: Authstatus.loading);
    try {
      // 1- Firebase Login
      final credential = await Repo.fireLogin(email, password);

      final user = credential.user;

      if (user != null) {
        debugPrint("Firebase UID = ${user.uid}");
        debugPrint("Firebase Email = ${user.email}");

        // 2-  Firebase UID to PHP  to get Token
        final res = await authService.firebaseLogin(user.uid, user.email ?? "");
        if (res != null && res["status"] == "success") {
          final prefs = await SharedPreferences.getInstance();
          final data = res["data"];
          final token = res["token"];

          debugPrint("PHP TOKEN = $token");
          await prefs.setString("token", token.toString());
          await prefs.setString("uid", user.uid);
          await prefs.setString("username", data["username"].toString());
          await prefs.setString("email", data["email"].toString());
          await prefs.setBool("seenOnboarding", true);

          state = Authstate(status: Authstatus.success);
          return credential;
        } else {
          state = Authstate(status: Authstatus.error, message: "login failed");

          return null;
        }
      }
      state = Authstate(status: Authstatus.error, message: "User not found");
      return null;
    } on FirebaseAuthException catch (e) {
      state = Authstate(status: Authstatus.error, message: e.message);
      return null;
    } catch (e) {
      state = Authstate(status: Authstatus.error, message: e.toString());
      return null;
    }
  }

  Future<bool> resetPassword(String email) async {
    state = Authstate(status: Authstatus.loading);

    try {
      await Repo.resetpassword(email);
      state = Authstate(status: Authstatus.success);
      return true;
    } on FirebaseAuthException catch (e) {
      state = Authstate(status: Authstatus.error, message: e.message);
      // debugPrint("ERROR CODE: ${e.code}");
      // debugPrint("ERROR MESSAGE: ${e.message}");
      return false;
    } catch (e) {
      state = Authstate(status: Authstatus.error, message: e.toString());
      return false;
    }
  }
}
