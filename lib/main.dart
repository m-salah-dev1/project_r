import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_r/app/auth/login/login_view.dart';
import 'package:project_r/app/auth/signup/signup.dart';
import 'package:project_r/app/auth/success.dart';
import 'package:project_r/app/notes/add/add.dart';
import 'package:project_r/app/notes/edit/edit.dart';
import 'package:project_r/app/notes/home/home.dart';
import 'package:project_r/model/notemodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',

      initialRoute:
          sharedPref.getString("id") == null ? "login_view" : "home",

      routes: {
        "login_view": (context) => LoginView(),
        "signup": (context) => SignUp(),
        "home": (context) => Home(),
        "success": (context) => Success(),
        "add": (context) => AddNotes(),
      },

      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "edit":
            final note = settings.arguments as NoteModel;

            return MaterialPageRoute(
              builder: (_) => EditNotes(notes: note),
            );

          default:
            return null;
        }
      },
    );
  }
}