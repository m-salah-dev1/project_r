import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_r/app/auth/login/login_controller.dart';
import 'package:project_r/components/customtextform.dart';
import 'package:project_r/components/valid.dart';


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
    
    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset("images/p7.png", width: 200),

                  CustTextForm(
                    hint: "email",
                    mycontroller: email,
                    valid: (val) {
                      return validIput(val!, 5, 20);
                    },
                  ),

                  CustTextForm(
                    hint: "password",
                    mycontroller: password,
                    valid: (val) {
                      return validIput(val!, 5, 20);
                    },
                  ),

                  ElevatedButton(
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;

                      final controller =
                          ref.read(authControllerProvider.notifier);

                      final res =
                          await controller.login(email.text, password.text);

                      if (!context.mounted) return;

                      if (res?["status"] == "success") {
                        Navigator.pushReplacementNamed(context, "home");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text("Password or Email is not valid"),
                          ),
                        );
                      }
                    },
                    child: const Text("Login"),
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