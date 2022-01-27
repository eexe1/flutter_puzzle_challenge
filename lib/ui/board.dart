import 'package:flutter/material.dart';
import 'package:flutter_puzzle_challenge/state/app_state.dart';
import 'package:flutter_puzzle_challenge/ui/box.dart';
import 'package:provider/provider.dart';

/// {@template board}
/// Model for a puzzle board.
/// {@endtemplate}
@visibleForTesting
class Board extends StatelessWidget {
  /// {@macro board}
  const Board({
    Key? key,
    this.spacing = 8,
  }) : super(key: key);

  /// The spacing between each tile from [tiles].
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
      return GridView.count(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: appState.dimensionSize,
        mainAxisSpacing: spacing,
        crossAxisSpacing: spacing,
        children:
            appState.puzzle.tiles.map((tile) => PuzzleBox(tile: tile)).toList(),
      );
    });
  }
}
