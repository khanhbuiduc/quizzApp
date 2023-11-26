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
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 128, 73, 223)),
          useMaterial3: true,
        ),
        home: const AuthScreen());
  }
}
