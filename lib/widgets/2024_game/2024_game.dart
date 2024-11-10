import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:math_games/provider/score.provider.dart';
import 'package:math_games/widgets/dialog/dialog_custom.dart';
import 'package:math_games/widgets/header/header.dart';

class Game2024 extends StatefulWidget {
  const Game2024({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Game2024State createState() => _Game2024State();
}

class _Game2024State extends State<Game2024> {
  final int gridSize = 6;
  late List<List<int>> grid;
  int winNumber = 0;

  @override
  void initState() {
    super.initState();
    initializeGrid();
  }

  int getRandomPowerOfTwo() {
    List<int> possibleValues = [0, 2, 4];
    return possibleValues[Random().nextInt(possibleValues.length)];
  }

  void initializeGrid() {
    grid = List.generate(
        gridSize, (_) => List.generate(gridSize, (_) => getRandomPowerOfTwo()));
  }

  void handleSwipe(DragEndDetails details) {
    if (details.velocity.pixelsPerSecond.dx.abs() >
        details.velocity.pixelsPerSecond.dy.abs()) {
      if (details.velocity.pixelsPerSecond.dx > 0) {
        swipeRight();
      } else {
        swipeLeft();
      }
    } else {
      if (details.velocity.pixelsPerSecond.dy > 0) {
        swipeDown();
      } else {
        swipeUp();
      }
    }
  }

  void swipeLeft() {
    setState(() {
      for (var row in grid) {
        mergeRow(row);
      }
      insertRandomItem();
    });
  }

  void swipeRight() {
    setState(() {
      for (int i = 0; i < grid.length; i++) {
        grid[i] = grid[i].reversed.toList();
        mergeRow(grid[i]);
        grid[i] = grid[i].reversed.toList();
      }
      insertRandomItem();
    });
  }

  void swipeUp() {
    setState(() {
      for (int col = 0; col < gridSize; col++) {
        List<int> column = [
          for (int row = 0; row < gridSize; row++) grid[row][col]
        ];
        mergeRow(column);
        for (int row = 0; row < gridSize; row++) {
          grid[row][col] = column[row];
        }
      }
      insertRandomItem();
    });
  }

  void swipeDown() {
    setState(() {
      for (int col = 0; col < gridSize; col++) {
        List<int> column = [
          for (int row = 0; row < gridSize; row++) grid[row][col]
        ].reversed.toList();
        mergeRow(column);
        column = column.reversed.toList();
        for (int row = 0; row < gridSize; row++) {
          grid[row][col] = column[row];
        }
      }
      insertRandomItem();
    });
  }

  void restart() {
    Navigator.of(context).pop();
    initializeGrid();
    winNumber = 0;
    final scoreProvider = Provider.of<ScoreProvider>(context, listen: false);
    int score = scoreProvider.score + 1;
    scoreProvider.verify(score);
    setState(() {});
  }

  void insertRandomItem() {
    // Find all empty cells
    List<Point<int>> emptyCells = [];
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        emptyCells.add(Point(i, j)); // Add the coordinates of the empty cell
        if (grid[i][j] == 64 && winNumber == 0) {
          winNumber++;
          show2024Win(context, restart);
        }
      }
    }
    // Select a random empty cell
    if (emptyCells.isNotEmpty) {
      Random rand = Random();
      Point<int> randomCell = emptyCells[rand.nextInt(emptyCells.length)];
      grid[randomCell.x][randomCell.y] = getRandomPowerOfTwo();
    } else {}
  }

  void mergeRow(List<int> row) {
    for (int i = 0; i < row.length - 1; i++) {
      if (row[i] != 0 && row[i] == row[i + 1]) {
        row[i] *= 2;
        row[i + 1] = 0;
      }
    }
    row.removeWhere((element) => element == 0);
    while (row.length < gridSize) {
      row.add(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: header(context, titleText: "2024"),
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
          child: GestureDetector(
            onHorizontalDragEnd: handleSwipe,
            onVerticalDragEnd: handleSwipe,
            child: GridView.builder(
              physics:
                  const NeverScrollableScrollPhysics(), // Prevents scrolling

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridSize,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemCount: gridSize * gridSize,
              itemBuilder: (context, index) {
                int row = index ~/ gridSize;
                int col = index % gridSize;
                return GridTile(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: grid[row][col] == 0
                          ? const Color.fromARGB(255, 124, 134, 134)
                          : Colors.orange[100 * (grid[row][col] % 9)],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      grid[row][col] == 0 ? '' : '${grid[row][col]}',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 23, 23, 23)),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
