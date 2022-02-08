import 'package:flutter/cupertino.dart';
import 'package:flutter_puzzle_challenge/models/models.dart';
import 'package:flutter_puzzle_challenge/tools/generator.dart';

class AppState extends ChangeNotifier {
  static const int size = 4;
  late Puzzle puzzle;

  /// If 0, no stage is selected.
  late int stage = 0;

  int get dimensionSize {
    return size;
  }

  void tapTile(Tile tile) {
    if (puzzle.isTileMovable(tile) && !puzzle.isComplete()) {
      final mutablePuzzle = Puzzle(tiles: [...puzzle.tiles]);
      mutablePuzzle.moveTiles(tile, []);
      puzzle = mutablePuzzle.sort();
      notifyListeners();
    }
  }

  void setStage(int stageNumber) {
    stage = stageNumber;
    _startPuzzle(stageNumber);
    notifyListeners();
  }

  void _startPuzzle(int stageNumber) {
    puzzle = generatePuzzle(size, stage: stageNumber).sort();
  }
}
