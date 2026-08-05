import 'package:firebase_auth/firebase_auth.dart';

class Repo {
  //! this for SignUp
  static Future<UserCredential> fireSignup(
    String email,
    String password,
  ) async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return credential;
  }

  //! this for login

  static Future<UserCredential> fireLogin(String email, String password) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return credential;
  }

  // ! logout
  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  // ! to know current User
  static User? curretUser() {
    return FirebaseAuth.instance.currentUser;
  }

  static Future<void> resetpassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
