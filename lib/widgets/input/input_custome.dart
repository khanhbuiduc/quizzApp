import 'package:flutter/material.dart';

class InputCustume extends StatelessWidget {
  const InputCustume({
    super.key,
    required this.hintText,
    required this.icon,
    required this.obscureText,
  });
  final String hintText;
  final Icon icon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: TextFormField(
        decoration: InputDecoration(
            border: InputBorder.none, icon: icon, hintText: hintText),
        obscureText: obscureText,
      ),
    );
  }
}
