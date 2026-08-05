import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_r/components/customtextform.dart';
import 'package:project_r/components/valid.dart';
import 'signup_provider.dart';


class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});
  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}



class _SignUpState extends ConsumerState<SignUp> {
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();



  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    if (!formstate.currentState!.validate()) return;
    if (password.text != confirmPassword.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("The Password not match"),
          backgroundColor: Colors.deepOrange,
        ),
      );
      return;
    }

    await ref.read(signUpProvider.notifier).signUp(
          username: username.text.trim(),
          email: email.text.trim(),
          password: password.text.trim(),
        );

    final state = ref.read(signUpProvider);
    state.whenOrNull(
      data: (_) {
        username.clear();
        email.clear();
        password.clear();
        confirmPassword.clear();
        Navigator.of(context)
            .pushReplacementNamed("login_view");
      },
      error: (err, _) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Sign up failed: $err"),
            backgroundColor: Colors.red,
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signUpProvider);
    return Scaffold(
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator(),)
          : Container(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  Form( key: formstate,
                    child: Column(
                      children: [
                        Image.asset("images/notepad.gif", width: 200, ),

                        CustTextForm(
                          hint: "username",
                          mycontroller: username,
                          valid: (val) =>
                              validIput(val!, 5, 20),
                        ),
                        CustTextForm(
                          hint: "email",
                          mycontroller: email,
                          valid: (val) =>
                              validIput(val!, 5, 50),
                        ),
                        CustTextForm(
                          hint: "password",
                          hiden: true,
                          mycontroller: password,
                          valid: (val) =>
                              validIput(val!, 5, 20),
                        ),

                        CustTextForm(
                          hint: "confirm-password",
                          hiden: true,
                          mycontroller: confirmPassword,
                          valid: (val) =>
                              validIput(val!, 5, 20),
                        ),

                        MaterialButton(
                          color: Colors.blue,
                          onPressed: signUp,
                          child: const Text( "Sign Up",),
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed("login_view",);
                                  },
                          child: const Text("Log in",),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}