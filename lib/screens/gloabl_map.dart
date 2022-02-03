import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vector_math/vector_math_64.dart';

class GlobalMap extends StatefulWidget {
  const GlobalMap({Key? key}) : super(key: key);

  @override
  State<GlobalMap> createState() => _GlobalMapState();
}

class _GlobalMapState extends State<GlobalMap> {
  late TransformationController _controller;

  @override
  void initState() {
    _controller = TransformationController();
    _controller.value = Matrix4.columns(
        Vector4(15.0, 0.0, 0.0, 0.0),
        Vector4(0.0, 15.0, 0.0, 0.0),
        Vector4(0.0, 0.0, 15.0, 0.0),
        Vector4(-1385.6412341565913, -657.1999161587044, 0.0, 1.0));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) => {print(details.localPosition)},
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
              Positioned(
                child: SvgPicture.asset(
                  'assets/images/marker.svg',
                ),
                width: 1.5,
                height: 1.5,
                top: 66.5,
                left: 98.5,
              ),
              Positioned(
                child: SvgPicture.asset(
                  'assets/images/marker.svg',
                ),
                width: 1.5,
                height: 1.5,
                top: 70.5,
                left: 104,
              ),
              Positioned(
                child: SvgPicture.asset(
                  'assets/images/marker.svg',
                ),
                width: 1.5,
                height: 1.5,
                top: 79.2,
                left: 113.4,
              ),
            ],
          )),
    );
  }
}
