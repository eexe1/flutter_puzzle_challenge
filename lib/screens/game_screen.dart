import 'package:flutter/material.dart';
import 'package:flutter_puzzle_challenge/state/app_state.dart';
import 'package:flutter_puzzle_challenge/ui/board.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static const stageTitles = [
    'Arc de Triomphe',
    'Colosseum',
    'The Great Pyramid of Giza'
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(stageTitles[value.stage - 1]),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Board(
              stage: value.stage,
            ),
          ),
        ),
      );
    });
  }
}
