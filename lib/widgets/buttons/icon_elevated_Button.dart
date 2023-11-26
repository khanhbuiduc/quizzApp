import 'package:flutter/material.dart';

class IconElevatedButton extends StatelessWidget {
  const IconElevatedButton(
      {super.key,
      required this.label,
      required this.icon,
      required this.color});
  final String label;
  final Icon icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              backgroundColor: color, foregroundColor: Colors.white),
          onPressed: () {},
          icon: icon,
          label: Text(label)),
    );
  }
}
