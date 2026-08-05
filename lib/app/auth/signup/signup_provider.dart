import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:project_r/app/auth/login/login_controller.dart';
import 'package:project_r/app/auth/repo.dart';


final signUpProvider = StateNotifierProvider<SignUpNotifier, AsyncValue<void>>(
  (ref) => SignUpNotifier(ref),
);

class SignUpNotifier extends StateNotifier<AsyncValue<void>> {

  final Ref ref;

  SignUpNotifier(this.ref)  : super(const AsyncValue.data(null));

  Future<void> signUp({required String username, required String email,required String password,}) async {

    state = const AsyncValue.loading();

    try {
      // 1- create user in Firebase
      final credential = await Repo.fireSignup( email.trim(),password.trim(),);

      final user = credential.user;

      if (user == null) {
        state = AsyncValue.error(
          "Firebase signup failed",
          StackTrace.current,
        );
        return;
      }



      // 2- send information about user to PHP

      final authService = ref.read( authServiceProvider, );


      final response = await authService.firebaseRegister(
        username.trim(),
        email.trim(),
        user.uid,
      );



      if (response != null && response["status"] == "success") {

        state = const AsyncValue.data(null);

      } else {

        state = AsyncValue.error(
          "PHP register failed",
          StackTrace.current,
        );
      }

    } on FirebaseAuthException catch (e, st) {
      state = AsyncValue.error(e.message ?? "Firebase error",st,);

    } catch (e, st) {

      state = AsyncValue.error( e , st);

    }
  }
}