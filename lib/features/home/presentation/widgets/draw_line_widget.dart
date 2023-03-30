import 'package:flutter/material.dart';

class DrawLine extends StatelessWidget {
  const DrawLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return     SizedBox(
      height: 1.0,
      child:  Container(
        margin: const EdgeInsetsDirectional.only(start: 10.0, end: 10.0),
        height: 5.0,
        color: Colors.white70,
      ),
    );
  }
}
