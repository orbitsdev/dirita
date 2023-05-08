






import 'package:flutter/material.dart';

class Titlewidget extends StatelessWidget {
  final  String text;
  const Titlewidget({
    Key? key,
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Text(
              text,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            );
  }
}


