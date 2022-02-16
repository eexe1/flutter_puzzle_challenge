import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_puzzle_challenge/screens/history_screen.dart';
import 'package:flutter_puzzle_challenge/screens/map_screen.dart';
import 'package:flutter_puzzle_challenge/state/app_state.dart';
import 'package:flutter_puzzle_challenge/ui/box.dart';
import 'package:provider/provider.dart';
import 'dart:async';

/// {@template board}
/// Model for a puzzle board.
/// {@endtemplate}
@visibleForTesting
class Board extends StatelessWidget {
  /// {@macro board}
  Board({
    Key? key,
    this.spacing = 8,
    required this.stage,
  }) : super(key: key);

  /// The spacing between each tile from [tiles].
  final double spacing;
  final int stage;

  late Timer _timer;
  final int _start = 10;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
      final boxes = appState.puzzle.tiles
          .map(
            (tile) => PuzzleBox(tile: tile),
          )
          .toList();
      final isComplete = appState.puzzle.isComplete();
      if (isComplete) {
        // Add final piece to replace white tile
        final lastTile = boxes[boxes.length - 1]
            .tile
            .copyWithWhitespace(isWhitespace: false);
        boxes.removeLast();
        boxes.add(PuzzleBox(tile: lastTile));

        _timer = Timer(
          const Duration(seconds: 2),
          () {
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text('Congratulations'),
                      content: const Text(
                          "You have won! Now let's learn the history."),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'OK');
                            Navigator.pop(context, 'OK');
                            // Navigator.pushReplacement(context, 'OK');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider.value(
                                          value: appState,
                                          builder: (context, child) {
                                            return const HistoryScreen();
                                          },
                                        )));
                          },
                          child: const Text('Sure'),
                        ),
                      ],
                    ));
          },
        );
      }

      return AspectRatio(
        aspectRatio: 1,
        child: SizedBox(
          child: LayoutGrid(
            columnSizes: const [auto, auto, auto, auto],
            rowSizes: const [auto, auto, auto, auto],
            rowGap: isComplete ? 0 : 12,
            columnGap: isComplete ? 0 : 12,
            children: boxes,
          ),
        ),
      );
    });
  }
}
