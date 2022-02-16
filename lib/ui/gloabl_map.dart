import 'package:flutter/material.dart';
import 'package:flutter_puzzle_challenge/screens/game_screen.dart';
import 'package:flutter_puzzle_challenge/state/app_state.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart';

/// Map for stage selection
class GlobalMap extends StatefulWidget {
  const GlobalMap({Key? key}) : super(key: key);

  @override
  State<GlobalMap> createState() => _GlobalMapState();
}

class _GlobalMapState extends State<GlobalMap>
    with SingleTickerProviderStateMixin {
  late TransformationController _controller;

  // Marker animation
  late Animation<double> _animation;
  late AnimationController _animationController;

  final List<Positioned> markers = [
    Positioned(
      key: GlobalKey(),
      child: SvgPicture.asset(
        'assets/images/marker.svg',
      ),
      width: 1.5,
      height: 1.5,
      top: 66.5,
      left: 98.5,
    ),
    Positioned(
      key: GlobalKey(),
      child: SvgPicture.asset(
        'assets/images/marker.svg',
      ),
      width: 1.5,
      height: 1.5,
      top: 70.5,
      left: 104,
    ),
    Positioned(
      key: GlobalKey(),
      child: SvgPicture.asset(
        'assets/images/marker.svg',
      ),
      width: 1.5,
      height: 1.5,
      top: 79.2,
      left: 113.4,
    ),
  ];

  static const 

  @override
  void initState() {
    _controller = TransformationController();
    _controller.value = Matrix4.columns(
        Vector4(15.0, 0.0, 0.0, 0.0),
        Vector4(0.0, 15.0, 0.0, 0.0),
        Vector4(0.0, 0.0, 15.0, 0.0),
        Vector4(-1197.8060290784667, -886.7837479458145, 0.0, 1.0));
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _animation = Tween<double>(begin: 0, end: 300).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
      return GestureDetector(
        onTapUp: (details) {
          for (var i = 0; i < markers.length; i++) {
            var newKey = markers[i].key as GlobalKey?;
            RenderBox? box =
                newKey?.currentContext?.findRenderObject() as RenderBox?;
            Offset? markerOffset = box?.localToGlobal(Offset.zero);
            if (markerOffset != null) {
              if (_isTappedOnMarker(markerOffset, details.globalPosition)) {
                appState.setStage(i + 1);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider.value(
                            value: appState,
                            builder: (context, child) {
                              return const GameScreen();
                            },
                          )),
                );
                break;
              }
            }
          }
        },
        child: InteractiveViewer(
            transformationController: _controller,
            constrained: false,
            minScale: 7,
            maxScale: 25,
            child: Stack(
              children: [
                SvgPicture.asset(
                  'assets/images/worldmap.svg',
                ),
                ...markers
              ],
            )),
      );
    });
  }

  bool _isTappedOnMarker(Offset markerOffset, Offset tapOffset) {
    if (tapOffset.dx > markerOffset.dx && tapOffset.dy > markerOffset.dy) {
      return (markerOffset - tapOffset).distanceSquared < 1700;
    } else {
      return false;
    }
  }
}
