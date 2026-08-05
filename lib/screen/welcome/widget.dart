import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomPage extends StatelessWidget {
  final PageController co;
  final String img;
  final String text;
  final String subtitle;
  final int index;
  final BuildContext cont;
  const CustomPage({
    super.key,
    required this.co,
    required this.img,
    this.text = "",
    required this.subtitle,
    required this.index,
    required this.cont,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 600,
          width: double.infinity,
          child: Image.asset(img, fit: BoxFit.cover),
        ),
        Container(margin: EdgeInsets.only(top: 20), child: Text(text)),
        Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Text(text),
        ),
        

        _nextButton(index, co, context),
      ],
    );
  }
}

Widget _nextButton(
  int index,
  PageController controller,
  BuildContext context,
) {
  return MaterialButton(
    onPressed: () async {
      final prefs = await SharedPreferences.getInstance();
      if (index < 2) {
        controller.animateToPage(
          index + 1,
          duration: Duration(seconds: 1),
          curve: Curves.ease,
        );
      } else {
        await prefs.setBool("hasOpenedBefore", true);
        if (!context.mounted) return;
        Navigator.of(context).pushNamed("login_view");
      }
    },
    child: Container(
      margin: EdgeInsets.all(0),
      height: 50,
      width: 300,
      child: Center(child: Text("Continue")),
    ),
  );

}
