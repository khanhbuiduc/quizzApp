import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/event_bus/event_bus.dart';
import 'package:quizz_app/provider/score.provider.dart';
import 'package:quizz_app/widgets/header/header.dart';
import 'dart:math';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class PlusScreen extends StatefulWidget {
  final String type;
  PlusScreen({super.key, this.type = "plus"});

  @override
  State<PlusScreen> createState() => new _PlusScreenState();
}

class _PlusScreenState extends State<PlusScreen> {
  double progress = 1.0;
  int remainingTime = 60; // Set initial time to 60 seconds
  Timer? timer;

  String equation = '';
  int correctAnswer = 0;

  int correct = 0;
  int wrong = 0;
  List<int> answerOptions = [];
  final List<Color> listColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
    Colors.brown,
    Colors.cyan,
    Colors.pink,
    Colors.teal,
  ];
  @override
  void initState() {
    super.initState();
    generateQuiz();

    remainingTime = 60; // Reset the countdown timer
    progress = 1.0; // Reset the progress bar
    startTimer(); // Restart the timer
  }

  void startTimer() {
    if (!mounted) return;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
          progress = remainingTime /
              60; // Calculate progress (remainingTime / total time)
        } else {
          timer.cancel(); // Stop the timer when it reaches 0
          showResultDialog(); // Show the modal dialog
        }
      });
    });
  }

  void showResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(
              255, 213, 46, 255), // Custom background color

          title: const Text('Time\'s Up!',
              style: TextStyle(
                  color: Color.fromARGB(
                      255, 238, 250, 57))), // Custom title text color
          content: Container(
            height: 100,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Correct answer: $correct',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 110, 255, 70),
                      fontWeight: FontWeight.bold,
                      fontSize: 20), // Custom content text color
                ),
                Text(
                  'Wrong answer: $wrong',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 254, 139, 139),
                      fontWeight: FontWeight.bold,
                      fontSize: 20), // Custom content text color
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                'OK',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                final scoreProvider =
                    Provider.of<ScoreProvider>(context, listen: false);
                int score = scoreProvider.score + 1;
                scoreProvider.verify(score);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void generateQuiz() {
    Random random = Random();
    int num1 = random.nextInt(10) + 1; // Random number between 1 and 50
    int num2 = random.nextInt(10) + 1; // Random number between 1 and 50
    correctAnswer = num1 + num2; // Calculate correct answer
    String _operation = '';
    final operations = ['+', '-', 'x'];
    _operation = operations[random.nextInt(operations.length)];

    switch (widget.type) {
      case "plus":
        correctAnswer = num1 + num2; // Calculate correct answer=
        break;
      case "minus":
        correctAnswer = num1 - num2;
        break;
      case "multiplication":
        correctAnswer = num1 * num2;
        break;
      case "divide":
        num2 = random.nextInt(9) + 1; // Avoid zero division
        num1 =
            num2 * (random.nextInt(10) + 1); // Ensure num1 is divisible by num2
        correctAnswer = num1 ~/ num2;
        break;
      case "calculations":
        int _calculateAnswer() {
          switch (_operation) {
            case '+':
              return num1 + num2;
            case '-':
              return num1 - num2;
            case 'x':
              return num1 * num2;
            default:
              return 0;
          }
        }
        correctAnswer = _calculateAnswer();
        break;
    }

    // Generate incorrect answers
    answerOptions = [
      correctAnswer,
      random.nextInt(100) + 1, // Incorrect answer 1
      random.nextInt(100) + 1, // Incorrect answer 2
      random.nextInt(100) + 1 // Incorrect answer 3
    ];

    // Ensure the answers are unique
    answerOptions = answerOptions.toSet().toList();

    // If answer options are less than 4 due to duplicates, regenerate incorrect answers
    while (answerOptions.length < 4) {
      answerOptions.add(random.nextInt(30) + 1);
      answerOptions = answerOptions.toSet().toList();
    }

    // Shuffle the answers so the correct one is in a random position
    answerOptions.shuffle();

    setState(() {
      switch (widget.type) {
        case "plus":
          equation = '$num1 + $num2 = ?';
          break;
        case "minus":
          equation = '$num1 - $num2 = ?';
          break;
        case "multiplication":
          equation = '$num1 * $num2 = ?';
          break;
        case "divide":
          num2 = random.nextInt(10) + 1; // Avoid zero division
          num1 = num2 *
              (random.nextInt(10) + 1); // Ensure num1 is divisible by num2
          equation = '$num1 / $num2 = ?';
          break;
        default:
          equation = '$num1 $_operation $num2 =?';
      }
    });
  }

  void checkAnswer(int selectedAnswer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (selectedAnswer == correctAnswer) {
      correct++;
      await prefs.setString("correct", '$correct');
    } else {
      wrong++;
      await prefs.setString("wrong", '$wrong');
    }
    generateQuiz();
  }

  @override
  void dispose() {
    // Make sure to cancel the timer when the widget is disposed
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: true,
      child: Scaffold(
          // key: _scaffoldKey,
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          appBar: header(context, titleText: "Plus Game"),
          body: Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 108, 26, 224),
                  Color.fromARGB(255, 192, 94, 195)
                ],
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 80,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // CircularProgressIndicator to represent the countdown
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          value: progress, // Progress value (1.0 means 100%)
                          strokeWidth: 5.0,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color.fromARGB(255, 249, 130, 39)),
                        ),
                      ),
                      // Display the remaining time in the center
                      Text(
                        '$remainingTime',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  equation,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.w900),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: width,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      crossAxisSpacing: 10, // Spacing between columns
                      mainAxisSpacing: 10, // Spacing between rows
                    ),
                    itemCount: answerOptions.length, // Number of items
                    itemBuilder: (context, index) {
                      int answer = answerOptions[index];
                      return GestureDetector(
                        onTap: () => checkAnswer(answer),
                        child: Container(
                          height: 40,
                          width: width / 2,
                          color: listColors[index],
                          child: Center(
                            child: Text(
                              "$answer",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      );
                    },
                    padding: const EdgeInsets.all(10),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
