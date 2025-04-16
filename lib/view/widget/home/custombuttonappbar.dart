import 'package:flutter/material.dart';

class Custombuttonappbar extends StatelessWidget {
  final void Function()? onPressed;
  final String textbutton;
  final IconData icondata ;

  final bool? active;

  const Custombuttonappbar({
    Key? key,
    required this.textbutton,
    required this.icondata,
    required this.onPressed,

    required this.active,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 30,
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icondata, size: 26,color:active==true ? Colors.blue : Colors.black),
          Text(textbutton, style: TextStyle(fontSize: 12,color:active==true ? Colors.blue : Colors.black)),
        ],
      ),
    );
  }
}
