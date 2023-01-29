import 'package:flutter/material.dart';

class BulletPoint extends StatelessWidget {
  final String text;
  const BulletPoint({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "\u2022",
          style: TextStyle(fontSize: 30),
        ), //bullet text
        SizedBox(
          width: 10,
        ), //space between bullet and text
        Expanded(
          child: Text(
            this.text,
            style: TextStyle(fontSize: 22.5),
          ), //text
        )
      ]),
    );
  }
}
