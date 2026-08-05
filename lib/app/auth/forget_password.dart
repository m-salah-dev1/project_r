import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_r/app/auth/login/login_controller.dart';
import 'package:project_r/components/customtextform.dart';
import 'package:project_r/components/valid.dart';
import 'package:project_r/constant/authstate.dart';

class ForgotPass extends ConsumerStatefulWidget {
  const ForgotPass({super.key});

  @override
  ConsumerState<ForgotPass> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends ConsumerState<ForgotPass> {
  final email = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Forgot Password")),

      body: authState.status == Authstatus.loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 30),

                    const Text(
                      "Enter your email to reset password",
                      style: TextStyle(fontSize: 18),
                    ),

                    const SizedBox(height: 20),

                    CustTextForm(
                      hint: "Email",
                      mycontroller: email,
                      valid: (val) {
                        return validIput(val!, 5, 50);
                      },
                    ),

                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) return;

                        final controller = ref.read(
                          authControllerProvider.notifier,
                        );
                        await controller.resetPassword(email.text.trim());

                        if (!context.mounted) return;

                        final authstate = ref.read(authControllerProvider);

                        if (authstate.status == Authstatus.success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Reset link sent to your email"),
                            ),
                          );
                          Navigator.pop(context);
                        }  else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Email not found")),
                          );
                          }
                      },

                      child: const Text("Send Reset Link"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
