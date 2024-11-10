import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:math_games/provider/score.provider.dart';
import 'package:math_games/widgets/header/header.dart';
import 'package:math_games/widgets/soguko_game/goku_cell.dart';
import 'package:math_games/widgets/soguko_game/sogoku_generator.dart';

class SudokuGameScreen extends StatefulWidget {
  @override
  _SudokuGameScreenState createState() => _SudokuGameScreenState();
}

class _SudokuGameScreenState extends State<SudokuGameScreen> {
  SudokuGenerator generator = SudokuGenerator();
  List<List<int>> puzzle = [];
  List<List<int>> defaultPuzzle = [];
  // Update board when the user inputs a number
  void updateCell(int row, int col, int value) {
    setState(() {
      puzzle[row][col] = value;
      if (checkIfSolved()) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Congratulations!"),
            content: Text("You've completed the Sudoku puzzle!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  final scoreProvider =
                      Provider.of<ScoreProvider>(context, listen: false);
                  int score = scoreProvider.score + 1;
                  scoreProvider.verify(score);
                  _resetGame();
                },
                child: Text("OK"),
              ),
            ],
          ),
        );
      }
    });
  }

  bool checkIfSolved() {
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        if (generator.board[row][col] != puzzle[row][col]) return false;
      }
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  void _resetGame() {
    generator.solveSudoku(); // Generates a full solution
    puzzle =
        generator.generatePuzzle(40); // Remove 40 cells for a medium puzzle

    defaultPuzzle = puzzle.map((row) => List<int>.from(row)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: header(context, titleText: "Sudoku Game"),
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 9,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                  ),
                  itemCount: 81,
                  itemBuilder: (context, index) {
                    int row = index ~/ 9;
                    int col = index % 9;
                    return SudokuCell(
                        value: puzzle[row][col],
                        onChanged: (val) => updateCell(row, col, val),
                        isEdit: defaultPuzzle[row][col] == 0);
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
