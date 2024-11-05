import 'dart:math';

class SudokuGenerator {
  final Random _random = Random();
  List<List<int>> board = List.generate(9, (_) => List.generate(9, (_) => 0));

  bool isValid(int row, int col, int num) {
    // Check row and column
    for (int i = 0; i < 9; i++) {
      if (board[row][i] == num || board[i][col] == num) return false;
    }

    // Check 3x3 subgrid
    int startRow = (row ~/ 3) * 3;
    int startCol = (col ~/ 3) * 3;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[startRow + i][startCol + j] == num) return false;
      }
    }
    return true;
  }

  bool solveSudoku() {
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        if (board[row][col] == 0) {
          // Try random numbers 1-9
          List<int> nums = List.generate(9, (i) => i + 1)..shuffle(_random);
          for (int num in nums) {
            if (isValid(row, col, num)) {
              board[row][col] = num;
              if (solveSudoku()) return true;
              board[row][col] = 0; // Backtrack
            }
          }
          return false;
        }
      }
    }
    return true; // Puzzle solved
  }

  List<List<int>> generatePuzzle(int emptyCells) {
    solveSudoku();
    List<List<int>> puzzle = board.map((row) => List<int>.from(row)).toList();

    int cellsRemoved = 0;
    while (cellsRemoved < emptyCells) {
      int row = _random.nextInt(9);
      int col = _random.nextInt(9);
      if (puzzle[row][col] != 0) {
        puzzle[row][col] = 0;
        cellsRemoved++;
      }
    }
    return puzzle;
  }
}

void main() {
  SudokuGenerator generator = SudokuGenerator();
  generator.solveSudoku(); // Generates a full solution
  print("Generated Solution:");
  generator.board.forEach((row) => print(row));

  List<List<int>> puzzle =
      generator.generatePuzzle(40); // Remove 40 cells for a medium puzzle
  print("\nGenerated Puzzle:");
  puzzle.forEach((row) => print(row));
}
