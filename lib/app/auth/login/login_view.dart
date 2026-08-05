import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_r/app/auth/login/login_controller.dart';
import 'package:project_r/components/customtextform.dart';
import 'package:project_r/components/valid.dart';
import 'package:project_r/constant/authstate.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      body: authState.status == Authstatus.loading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset("images/notepad.gif", width: 200),
                  SizedBox(height: 10,),
                  CustTextForm(
                    hint: "email",
                    mycontroller: email,
                    valid: (val) {
                      return validIput(val!, 5, 20);
                    },
                  ),

                  CustTextForm(
                    hint: "password",
                    hiden: true,
                    mycontroller: password,
                    valid: (val) {
                      return validIput(val!, 5, 20);
                    },
                  ),

                  ElevatedButton(
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;

                      final controller = ref.read(authControllerProvider.notifier,);

                      await controller.login(email.text,password.text,);

                      if (!context.mounted) return;

                      final state = ref.read(authControllerProvider);

                      if (state.status == Authstatus.success) {
                        Navigator.pushReplacementNamed(context, "home");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:  
                                Text(state.message ?? "login Failed"),
                          ),
                        );
                      }
                    },
                    child: const Text("Login"),
                  ),
                  const SizedBox(height: 10),

                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("forgetPassword");
                    },
                    child: Text("Forget Password ?..."),
                  ),

                  const SizedBox(height: 10),

                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "signup");
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
