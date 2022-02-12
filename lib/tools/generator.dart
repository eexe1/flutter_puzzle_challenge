import 'package:flutter_puzzle_challenge/models/models.dart';

/// Build a randomized, solvable puzzle of the given size and a stage number.
Puzzle generatePuzzle(int size, {bool shuffle = true, int stage = 1}) {
  final correctPositions = <Position>[];
  final currentPositions = <Position>[];
  final whitespacePosition = Position(x: size, y: size);

  // Create all possible board positions.
  for (var y = 1; y <= size; y++) {
    for (var x = 1; x <= size; x++) {
      if (x == size && y == size) {
        correctPositions.add(whitespacePosition);
        currentPositions.add(whitespacePosition);
      } else {
        final position = Position(x: x, y: y);
        correctPositions.add(position);
        currentPositions.add(position);
      }
    }
  }

  if (shuffle) {
    // Randomize only the current tile posistions.
    currentPositions.shuffle();
  }

  var tiles = _getTileListFromPositions(
    size,
    correctPositions,
    currentPositions,
    stage,
  );

  var puzzle = Puzzle(tiles: tiles);

  if (shuffle) {
    // Assign the tiles new current positions until the puzzle is solvable and
    // zero tiles are in their correct position.
    while (!puzzle.isSolvable() || puzzle.getNumberOfCorrectTiles() != 0) {
      currentPositions.shuffle();
      tiles = _getTileListFromPositions(
        size,
        correctPositions,
        currentPositions,
        stage,
      );
      puzzle = Puzzle(tiles: tiles);
    }
  }

  return puzzle;
}

/// Build a list of tiles - giving each tile their correct position and a
/// current position.
List<Tile> _getTileListFromPositions(
  int size,
  List<Position> correctPositions,
  List<Position> currentPositions,
  int stage,
) {
  final whitespacePosition = Position(x: size, y: size);
  return [
    for (int i = 1; i <= size * size; i++)
      if (i == size * size)
        Tile(
          value: i,
          correctPosition: whitespacePosition,
          currentPosition: currentPositions[i - 1],
          isWhitespace: true,
        )
      else
        Tile(
            value: i,
            correctPosition: correctPositions[i - 1],
            currentPosition: currentPositions[i - 1],
            imageAssetKey:
                "assets/images/puzzles/$stage/${i.toString().padLeft(2, '0')}.png")
  ];
}
