import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BorderBox extends StatelessWidget {
  Color color;
  String text;

  BorderBox({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: color, width: 2.0),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          text,
          style: TextStyle(
            color: color,
          ),
        ),
      ),
    );
  }
}
