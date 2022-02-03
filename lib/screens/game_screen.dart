import 'package:flutter/material.dart';
import 'package:flutter_puzzle_challenge/screens/gloabl_map.dart';
import 'package:flutter_puzzle_challenge/state/app_state.dart';
import 'package:flutter_puzzle_challenge/ui/board.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
        title: Text(widget.title),
      ),
      body: Center(
        child: ChangeNotifierProvider(
          create: (context) => AppState(),
          child: Consumer<AppState>(
            builder: (context, value, child) {
              return value.stage == 0
                  ? const GlobalMap()
                  : const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Board(),
                    );
            },
          ),
        ),
      ),
    );
  }
}
