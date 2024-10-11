import 'dart:async';

import 'package:flutter/material.dart';

class CircularCountdownScreen extends StatefulWidget {
  const CircularCountdownScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CircularCountdownScreenState createState() =>
      _CircularCountdownScreenState();
}

class _CircularCountdownScreenState extends State<CircularCountdownScreen> {
  double progress =
      1.0; // Progress for the CircularProgressIndicator (1.0 is full circle)
  int remainingTime = 60; // Start from 60 seconds
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
          progress = remainingTime /
              60; // Calculate progress (remainingTime / total time)
        } else {
          timer.cancel(); // Stop the timer when it reaches 0
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Circular Countdown Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // CircularProgressIndicator to represent the countdown
                CircularProgressIndicator(
                  value: progress, // Progress value (1.0 means 100%)
                  strokeWidth: 10.0,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
                // Display the remaining time in the center
                Text(
                  '$remainingTime',
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  remainingTime = 60; // Reset the countdown timer
                  progress = 1.0; // Reset the progress bar
                  startTimer(); // Restart the timer
                });
              },
              child: Text('Restart Timer'),
            ),
          ],
        ),
      ),
    );
  }
}
