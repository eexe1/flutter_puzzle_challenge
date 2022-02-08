import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_puzzle_challenge/screens/map_screen.dart';
import 'package:flutter_puzzle_challenge/typography/typography.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final int _numPages = 4;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  late final AnimationController _animationController;

  final Map<int, Duration> animationDuration = {};

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : const Color(0xFF7B51D3),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  void navigateToGame() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const MapScreen();
    }));
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this);
    _pageController.addListener(() {
      if ([1].contains(_pageController.page)) {
        var page = _pageController.page?.toInt();
        // when page scrolling is done
        if (page != 0 && animationDuration[page] != null) {
          _animationController.reset();
          _animationController.duration = animationDuration[page];
          _animationController.forward();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.9],
              colors: [
                Color(0xFF5EC6E4),
                Color(0xFF3AA1C0),
                Color(0xFF5036D5),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      navigateToGame();
                    },
                    child: Text(
                      'Skip',
                      style: PuzzleTextStyle.onboardingSkip,
                    ),
                  ),
                ),
                SizedBox(
                  height: 600.0,
                  child: PageView(
                    physics: const ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      /// Page 1
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: SvgPicture.asset(
                                'assets/images/onboarding1.svg',
                                semanticsLabel: 'Onboarding 1 suitcase',
                                height: 300,
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            Text(
                              'Wonders of the World',
                              style: PuzzleTextStyle.onboardingHeadline,
                            ),
                            const SizedBox(height: 15.0),
                            Text(
                              'Collect Wonders and explore them.',
                              style: PuzzleTextStyle.onboardingSubtitle,
                            ),
                          ],
                        ),
                      ),

                      /// Page 2
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Lottie.asset(
                                'assets/images/onboarding2.json',
                                height: 300,
                                controller: _animationController,
                                onLoaded: (composition) {
                                  animationDuration[1] = composition.duration;
                                },
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            Text(
                              'Solve Puzzle',
                              style: PuzzleTextStyle.onboardingHeadline,
                            ),
                            const SizedBox(height: 15.0),
                            Text(
                              'Move the pieces to complete a Wonder.',
                              style: PuzzleTextStyle.onboardingSubtitle,
                            ),
                          ],
                        ),
                      ),

                      /// Page 3
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Lottie.asset(
                                'assets/images/onboarding3.json',
                                height: 300,
                                repeat: false,
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            Text(
                              'Moving Rule 1',
                              style: PuzzleTextStyle.onboardingHeadline,
                            ),
                            const SizedBox(height: 15.0),
                            Text(
                              'Only tiles adjacent with a blank tile can be moved.',
                              style: PuzzleTextStyle.onboardingSubtitle,
                            ),
                          ],
                        ),
                      ),

                      /// Page 4
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Lottie.asset(
                                'assets/images/onboarding4.json',
                                height: 300,
                                repeat: false,
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            Text(
                              'Moving Rule 2',
                              style: PuzzleTextStyle.onboardingHeadline,
                            ),
                            const SizedBox(height: 15.0),
                            Text(
                              'Multiple tiles from a same row or column can be moved at once if there\'s a white tile on one end.',
                              style: PuzzleTextStyle.onboardingSubtitle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                ),
                if (_currentPage != _numPages - 1)
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Next',
                              style: PuzzleTextStyle.onboardingNext,
                            ),
                            const SizedBox(width: 10.0),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 115.0,
              width: double.infinity,
              color: const Color(0xFF439DBC),
              child: TextButton(
                onPressed: navigateToGame,
                child: Text(
                  'I am ready!',
                  style: PuzzleTextStyle.onboardingReady,
                ),
              ))
          : null,
    );
  }
}
