import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:project_r/components/crud.dart';
import 'package:project_r/constant/linkapi.dart';

final signUpProvider =
    StateNotifierProvider<SignUpNotifier, AsyncValue<void>>(
  (ref) => SignUpNotifier(),
);

class SignUpNotifier extends StateNotifier<AsyncValue<void>> {
  SignUpNotifier() : super(const AsyncValue.data(null));

  final Crud _crud = Crud();

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    try {
      final response = await _crud.postRequest(linkSignUp, {
        "username": username.trim(),
        "email": email.trim(),
        "password": password.trim(),
      });

      if (response != null &&
          response is Map &&
          response["status"] == "success") {
        state = const AsyncValue.data(null);
      } else {
        state = AsyncValue.error("Sign up failed", StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}