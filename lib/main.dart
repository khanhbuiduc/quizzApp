import 'package:flutter/material.dart';
import 'package:quizz_app/screen/home/home_page.dart';
import 'package:quizz_app/screen/home/home_page_header.dart';
import 'package:quizz_app/screen/auth/authScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData().copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage());
  }
}
