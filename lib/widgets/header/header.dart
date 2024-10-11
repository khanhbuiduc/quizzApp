import 'package:flutter/material.dart';

AppBar header(context, {String? titleText = "", Function? onPressed}) {
  return AppBar(
    title: Text(
      titleText ?? '',
      style: const TextStyle(
        color: Color.fromRGBO(255, 255, 255, 1),
        fontFamily: "Signatra",
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
    backgroundColor: const Color.fromARGB(255, 108, 26, 224),
    automaticallyImplyLeading: false,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white, weight: 700),
      onPressed: () => {Navigator.of(context).pop()},
    ),
  );
}
