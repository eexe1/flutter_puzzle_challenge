import 'package:flutter/material.dart';
import 'package:flutter_puzzle_challenge/colors/colors.dart';
import 'package:flutter_puzzle_challenge/models/models.dart';
import 'package:flutter_puzzle_challenge/state/app_state.dart';
import 'package:flutter_puzzle_challenge/typography/typography.dart';
import 'package:provider/provider.dart';

class PuzzleBox extends StatelessWidget {
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
        : PuzzleTile(tile: tile, tileFontSize: 14);
  }
}

/// {@template puzzle_tile}
/// Displays the puzzle tile associated with [tile] and
/// the font size of [tileFontSize] based on the puzzle [state].
/// {@endtemplate}
@visibleForTesting
class PuzzleTile extends StatelessWidget {
  /// {@macro puzzle_tile}
  const PuzzleTile({
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
      return TextButton(
        style: TextButton.styleFrom(
          primary: PuzzleColors.white,
          textStyle: PuzzleTextStyle.headline2.copyWith(
            fontSize: tileFontSize,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ).copyWith(
          foregroundColor: MaterialStateProperty.all(PuzzleColors.white),
          backgroundColor: MaterialStateProperty.all(PuzzleColors.black),
        ),
        onPressed: () => {appState.tapTile(tile)},
        child: Text(
          tile.value.toString(),
        ),
      );
    });
  }
}
