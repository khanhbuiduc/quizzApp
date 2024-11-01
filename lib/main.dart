import 'package:flutter/material.dart';
import 'package:quizz_app/provider/score.provider.dart';
import 'package:quizz_app/screen/home/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScoreProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Math app',
        theme: ThemeData().copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/dashboard',
        routes: <String, WidgetBuilder>{
          '/dashboard': (BuildContext context) => const MyHomePage(),
        },
        home: const MyHomePage());
  }
}
