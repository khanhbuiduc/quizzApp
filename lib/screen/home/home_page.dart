import 'package:flutter/material.dart';
import 'package:quizz_app/screen/home/home_page_header.dart';
import 'package:quizz_app/widgets/image_box/image_box_left.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 108, 26, 224),
          flexibleSpace: const HomePageHeader(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 108, 26, 224),
              Color.fromARGB(255, 211, 118, 214)
            ], // Add your desired colors here
          ),
        ),
        child: const Center(
          child: Text(
            'Hello, Flutter!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
