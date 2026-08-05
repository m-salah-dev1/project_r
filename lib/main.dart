import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_r/app/auth/forget_password.dart';
import 'package:project_r/app/auth/login/login_view.dart';
import 'package:project_r/app/auth/signup/signup.dart';
import 'package:project_r/app/auth/success.dart';
import 'package:project_r/app/notes/add/add.dart';
import 'package:project_r/app/notes/edit/edit.dart';
import 'package:project_r/firebase_options.dart';
import 'package:project_r/screen/home/home.dart';
import 'package:project_r/model/notemodel.dart';
import 'package:project_r/screen/welcom/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  sharedPref = await SharedPreferences.getInstance();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final token = sharedPref.getString("token");
    final seenOnboarding = sharedPref.getBool("seenOnboarding") ?? false;
    final fireUser = FirebaseAuth.instance.currentUser;
    String page;
    if (token != null && token.isNotEmpty && fireUser != null) {
      page = "home";
    } else if (seenOnboarding) {
      page = "login_view";
    } else {
      page = "/";
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',

      initialRoute: page,

      routes: {
        "/": (context) => Onboarding(),
        "login_view": (context) => LoginView(),
        "signup": (context) => SignUp(),
        "home": (context) => Home(),
        "success": (context) => Success(),
        "add": (context) => AddNotes(),
        "forgetPassword": (context)=> ForgotPass()
      },

      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "edit":
            final note = settings.arguments as NoteModel;

            return MaterialPageRoute(builder: (_) => EditNotes(notes: note));

          default:
            return null;
        }
      },
    );
  }
}
