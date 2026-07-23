import 'package:flutter/material.dart';

class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
       
    body: 
       Column ( 
        mainAxisAlignment: MainAxisAlignment.center,
            children: [ 
                Center(
                  child:
                    Text( " success to signup you have to go page login  "),),
                    MaterialButton( 
                        color: Colors.blue,
                        textColor: Colors.white,
                        onPressed: (){  
                          Navigator.of(context).pushNamedAndRemoveUntil("login_view",(route) => false);
                          },
                        child: Text(" Log in  "),
                        )],),
    );
  }
}