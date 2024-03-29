import 'package:flutter/material.dart';
import 'package:flutter_puzzle_challenge/ui/gloabl_map.dart';
import 'package:flutter_puzzle_challenge/state/app_state.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final appState = AppState();
  int? selectedListIndex;
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: const Text('World Puzzle'),
      ),
      body: Column(children: [
        ChangeNotifierProvider(
            create: (context) => appState,
            child: const Expanded(
              child: GlobalMap(),
              flex: 5,
            )),
        Expanded(
          child: ListView(
            children: [1, 2, 3]
                .map((index) => Padding(
                      child: GestureDetector(
                        child: Image.asset(
                            'assets/images/puzzles/complete/$index.jpeg'),
                        onTap: () {
                          selectedListIndex = index;
                        },
                      ),
                      padding: const EdgeInsets.all(24.0),
                    ))
                .toList(),
            scrollDirection: Axis.horizontal,
          ),
          flex: 3,
        )
      ]),
    );
  }
}
