import 'package:flutter/cupertino.dart';
import 'package:flutter_puzzle_challenge/models/models.dart';
import 'package:flutter_puzzle_challenge/tools/generator.dart';

class AppState extends ChangeNotifier {
  static const int size = 4;
  late Puzzle puzzle;

  AppState() {
    puzzle = generatePuzzle(size).sort();
  }

  void tapTile(Tile tile) {
    if (puzzle.isTileMovable(tile)) {
      final mutablePuzzle = Puzzle(tiles: [...puzzle.tiles]);
      mutablePuzzle.moveTiles(tile, []);
      puzzle = mutablePuzzle.sort();
      notifyListeners();
    }
  }

  int get dimensionSize {
    return size;
  }
}
