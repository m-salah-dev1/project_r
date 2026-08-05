import 'package:flutter/material.dart';

class CustTextForm extends StatelessWidget {

    final String hint;
    final String? Function(String?) valid;    
    final TextEditingController mycontroller;         //!  for save data
    final bool hiden ;
    const CustTextForm({ 
        super.key,
        required this.hint ,
        required this.mycontroller, 
        required this.valid, 
        this.hiden = false});


 @override
  Widget build(BuildContext context) {

        return Container(
          margin: EdgeInsets.only(bottom: 10),
          child: TextFormField( 
            
            obscureText: hiden,
            validator: valid,
            controller: mycontroller ,
            decoration: InputDecoration( 
                  contentPadding: EdgeInsets.symmetric(vertical: 8 ,horizontal: 10),
                  hintText: hint,
                  border:  OutlineInputBorder( 
                      borderSide: BorderSide(color: Colors.black , width: 1),
                      borderRadius:  BorderRadius.all(Radius.circular(10))
                    )),),);
  }
}