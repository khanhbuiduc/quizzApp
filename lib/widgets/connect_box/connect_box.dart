import 'package:flutter/material.dart';
import 'package:quizz_app/widgets/button/border_box.dart';
import 'package:quizz_app/widgets/connect_box/box_widget.dart';
import 'package:quizz_app/widgets/connect_box/line_painter.dart';
import 'package:math_expressions/math_expressions.dart'; // For parsing expressions

class ConnectBoxesScreen extends StatefulWidget {
  @override
  _ConnectBoxesScreenState createState() => _ConnectBoxesScreenState();
}

class _ConnectBoxesScreenState extends State<ConnectBoxesScreen> {
  // Positions for fixed boxes
  final Offset box1Position = const Offset(0, 0);
  final Offset box2Position = const Offset(0, 0);

  // Position of the line being drawn
  Offset? lineEndPosition;
  final TextEditingController _inputController = TextEditingController();
  String result = ''; // Result displayed in Box B

  // Function to evaluate the expression from Box A
  void calculateResult(String expression) {
    try {
      Parser parser = Parser();
      Expression exp = parser.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      setState(() {
        result = eval.toString();
      });
    } catch (e) {
      setState(() {
        result = "Error";
      });
    }
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Draw to Connect Boxes')),
      body: GestureDetector(
        // Start drawing line from Box 1
        onPanStart: (details) {
          setState(() {
            lineEndPosition =
                box1Position + const Offset(25, 25); // Start at Box 1 center
          });
        },
        // Update line end position as user drags
        onPanUpdate: (details) {
          setState(() {
            lineEndPosition = details.localPosition;
          });
        },
        // Check if line end reaches Box 2 when drag ends
        onPanEnd: (details) {
          final box2Center =
              box2Position + const Offset(25, 25); // Center of Box 2
          if ((lineEndPosition! - box2Center).distance < 30) {
            // Allowable margin for "connection"
            _showAlert();
          }
          setState(() {
            lineEndPosition = null; // Reset the line
          });
        },
        child: Stack(
          children: [
            // CustomPaint for drawing the line
            CustomPaint(
              size: Size.infinite,
              painter: LinePainter(box1Position, lineEndPosition),
            ),
            // Box 1
            Positioned(
                left: box1Position.dx,
                top: box1Position.dy,
                // child: BoxWidget(color: Colors.blue),
                child: BorderBox(color: Colors.blue, text: "1+1")),
            Positioned(
                left: box1Position.dx,
                top: box1Position.dy + 50,
                // child: BoxWidget(color: Colors.blue),
                child: BorderBox(color: Colors.blue, text: "1+1")),
            Positioned(
                left: box1Position.dx,
                top: box1Position.dy + 100,
                // child: BoxWidget(color: Colors.blue),
                child: BorderBox(color: Colors.blue, text: "1+1")),
            Positioned(
                left: box1Position.dx,
                top: box1Position.dy + 200,
                // child: BoxWidget(color: Colors.blue),
                child: BorderBox(color: Colors.blue, text: "1+1")),
            Positioned(
                left: box1Position.dx,
                top: box1Position.dy + 300,
                // child: BoxWidget(color: Colors.blue),
                child: BorderBox(color: Colors.blue, text: "1+1")),
            // Box 2
            Positioned(
                right: box2Position.dx,
                top: box2Position.dy,
                child: BorderBox(
                    color: const Color.fromARGB(255, 233, 91, 9), text: "2")),
          ],
        ),
      ),
    );
  }

  // Function to show alert
  void _showAlert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text('You connected the two boxes!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
