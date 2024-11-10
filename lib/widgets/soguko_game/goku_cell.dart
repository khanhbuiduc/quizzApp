import 'package:flutter/material.dart';

class SudokuCell extends StatelessWidget {
  final int value;
  final Function(int) onChanged;
  final bool isEdit;

  SudokuCell(
      {required this.value, required this.onChanged, required this.isEdit});

  void onTap(context) async {
    if (!isEdit) {
      return;
    }
    int? newValue = await _showNumberPicker(context);
    if (newValue != null) {
      onChanged(newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: isEdit && value != 0
              ? Color.fromARGB(255, 247, 213, 158)
              : value == 0
                  ? Colors.white
                  : Colors.grey[300],
        ),
        child: Text(
          value == 0 ? '' : value.toString(),
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Future<int?> _showNumberPicker(BuildContext context) {
    return showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Pick a number'),
          children: List.generate(9, (index) {
            return SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, index + 1);
              },
              child: Text((index + 1).toString()),
            );
          }),
        );
      },
    );
  }
}
