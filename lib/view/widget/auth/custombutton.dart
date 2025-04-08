import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const Custombutton({Key? key, required this.text,this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: const EdgeInsets.only(top: 10),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.symmetric(vertical: 13),onPressed: onPressed,
        minWidth: double.infinity,
        color: Colors.blueAccent,
        textColor: Colors.white,
        child: Text(text,),

      ),
    );
  }
}
