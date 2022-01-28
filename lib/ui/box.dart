import 'package:flutter/material.dart';
import 'package:flutter_puzzle_challenge/models/models.dart';
import 'package:flutter_puzzle_challenge/state/app_state.dart';
import 'package:provider/provider.dart';

/// {@template puzzle_box}
/// A box contains either a puzzle tile [_PuzzleTile] or an empty box.
/// {@endtemplate}
class PuzzleBox extends StatelessWidget {
  /// {@macro puzzle_box}
  const PuzzleBox({
    Key? key,
    required this.tile,
  }) : super(key: key);

  /// The tile to be displayed.
  final Tile tile;

  @override
  Widget build(BuildContext context) {
    return tile.isWhitespace
        ? const SizedBox()
        : _PuzzleTile(tile: tile, tileFontSize: 14);
  }
}

/// {@template puzzle_tile}
/// Displays the puzzle tile associated with [tile] and
/// the font size of [tileFontSize] based on the puzzle [state].
/// {@endtemplate}
class _PuzzleTile extends StatelessWidget {
  /// {@macro puzzle_tile}
  const _PuzzleTile({
    Key? key,
    required this.tile,
    required this.tileFontSize,
  }) : super(key: key);

  /// The tile to be displayed.
  final Tile tile;

  /// The font size of the tile to be displayed.
  final double tileFontSize;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
      return GestureDetector(
        child: tile.imageAssetKey != null
            ? Image.asset(tile.imageAssetKey!)
            : null,
        onTap: () => {appState.tapTile(tile)},
      );
    });
  }
}
