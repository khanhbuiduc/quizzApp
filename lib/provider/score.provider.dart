// ignore: file_names
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreProvider with ChangeNotifier, DiagnosticableTreeMixin {
  int _score = 0;
  int get score => _score;
  // Load the counter value from SharedPreferences
  Future<void> _loadCounterFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _score = prefs.getInt('score') ?? 0;
    notifyListeners();
  }

  ScoreProvider() {
    _loadCounterFromPrefs();
  }

  void increment() {
    _score++;
    notifyListeners();
  }

  void verify(int newScore) async {
    _score = newScore;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("score", score);
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('score', score));
  }
}
