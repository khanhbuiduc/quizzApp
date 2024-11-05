// Widget for each box
import 'package:flutter/material.dart';

class BoxWidget extends StatelessWidget {
  final Color color;
  BoxWidget({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: color,
    );
  }
}
